
import fastifyFactory, { FastifyRequest, FastifyReply } from 'fastify'
import fastifyView from '@fastify/view'
import fastifyFormBody from '@fastify/formbody'
import ejs from 'ejs'
import path from 'path'
import { Proposal as DBProposal } from '@prisma/client'
import { queueAccepted, queueEdited } from './services/pubsub'
import { repositories } from './repositories'
import { logger } from './logging'

export const fastify = fastifyFactory({ logger })

void fastify.register(fastifyView, {
  engine: {
    ejs,
  },
  root: path.join(__dirname, 'templates'),
})
void fastify.register(fastifyFormBody)

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

fastify.get('/proposals/:proposalId/review', async (request, reply) => {
  const proposal = await fetchAndValidateProposal(request, reply)

  if (proposal === null) {
    return
  }

  return reply.view('/proposals.review.ejs', { proposal, route: `/proposals/${proposal.id}/review` })
})

fastify.post('/proposals/:proposalId/review/accept', async (request, reply) => {
  const proposal = await fetchAndValidateProposal(request, reply)

  if (proposal === null) {
    return
  }

  await queueAccepted(proposal)

  return reply.send('Junior description was accepted and will appear in the app shortly')
})

fastify.post('/proposals/:proposalId/review/edit', async (request, reply) => {
  const { newSeniorDescription } = request.body as { newSeniorDescription?: string }

  if (!newSeniorDescription) {
    return reply.send(422).send('Unprocessable entity')
  }

  const proposal = await fetchAndValidateProposal(request, reply)

  if (proposal === null) {
    return
  }

  await queueEdited(proposal, newSeniorDescription)

  return reply.send('New senior description was sent for AI generation')
})

export const server = fastify
