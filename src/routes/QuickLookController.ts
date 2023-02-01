import { FastifyInstance, FastifyRequest, FastifyReply } from 'fastify'
import { Proposal as DBProposal } from '@prisma/client'

import { queueAccepted, queueEdited } from '../services/pubsub'

import { repositories } from '../repositories'

const fetchAndValidateProposal = async (request: FastifyRequest, reply: FastifyReply): Promise<DBProposal | null> => {
  const { proposalId } = request.params as { proposalId: string }

  const proposal = await repositories.proposal.findFirst({
    where: {
      id: Number(proposalId),
    },
  })

  if (!proposal) {
    await reply.status(404).send('Proposal not found')
    return null
  }

  if (proposal.issueNumber !== null) {
    await reply.status(403).send('Proposal was already accepted')
    return null
  }

  return proposal
}

export const QuickLookController = async (fastify: FastifyInstance) => {
  fastify.get('/proposals/:proposalId/review', async (request: FastifyRequest, reply: FastifyReply) => {
    const proposal = await fetchAndValidateProposal(request, reply)

    if (proposal === null) {
      return
    }

    const dao = await repositories.dao.findFirst({ where: { id: proposal.daoId } })

    return reply.view('/proposals.review.ejs', { proposal, route: `/proposals/${proposal.id}/review`, daoName: dao ? dao.name : 'Unknown' })
  })

  fastify.post('/proposals/:proposalId/review/accept', async (request: FastifyRequest, reply: FastifyReply) => {
    const proposal = await fetchAndValidateProposal(request, reply)

    if (proposal === null) {
      return
    }

    await queueAccepted(proposal)

    return reply.send('Junior description was accepted and will appear in the app shortly')
  })

  fastify.post('/proposals/:proposalId/review/edit', async (request: FastifyRequest, reply: FastifyReply) => {
    const { newSeniorDescription, configName } = request.body as { newSeniorDescription?: string; configName?: string }

    if (!newSeniorDescription || !configName) {
      return reply.send(422).send('Unprocessable entity')
    }

    const proposal = await fetchAndValidateProposal(request, reply)

    if (proposal === null) {
      return
    }

    await queueEdited(proposal, newSeniorDescription, configName)

    return reply.send('New senior description was sent for AI generation')
  })
}
