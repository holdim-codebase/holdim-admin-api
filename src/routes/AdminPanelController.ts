import { FastifyInstance, FastifyRequest, FastifyReply } from 'fastify'
import { Dao as DBDao } from '@prisma/client'

import { repositories } from '../repositories'

export const AdminPanelController = async (fastify: FastifyInstance) => {
  fastify.addHook('onRequest', fastify.basicAuth)

  // DAOs
  fastify.get('/daos', async (request: FastifyRequest, reply: FastifyReply) => {
    let { sort, range } = request.query as { sort: string, range: string }

    if (!sort) { sort = '["id", "desc"]' }
    if (!range) { range = '[0, 10]' }

    const [field, order] = JSON.parse(sort)
    const [skip, take] = JSON.parse(range)

    const [count, daos] = await repositories.$transaction([
      repositories.dao.count(),
      repositories.dao.findMany({
        skip,
        take,
        orderBy: { [field]: order.toLowerCase() },
      }),
    ])

    return reply
      .header('X-Total-Count', count)
      .send(daos)
  })

  fastify.get('/daos/:id', async (request: FastifyRequest, reply: FastifyReply) => {
    const { id } = request.params as { id: string }

    const dao = await repositories.dao.findFirst({
      where: { id: Number(id) },
    })

    if (!dao) {
      return reply.status(404).send()
    }

    return dao
  })

  fastify.post('/daos', async (request: FastifyRequest, reply: FastifyReply) => {
    const data = request.body as DBDao

    const dao = await repositories.dao.create({ data })

    return reply.status(201).send(dao)
  })

  fastify.put('/daos/:id', async (request: FastifyRequest, reply: FastifyReply) => {
    const { id } = request.params as { id: string }
    const data = request.body as DBDao

    const dao = await repositories.dao.update({
      data,
      where: { id: Number(id) },
    })

    return reply.status(202).send(dao)
  })

  // Proposals
  fastify.get('/proposals', async (request: FastifyRequest, reply: FastifyReply) => {
    let { sort, range } = request.query as { sort: string, range: string }

    if (!sort) { sort = '["id", "desc"]' }
    if (!range) { range = '[0, 10]' }

    const [field, order] = JSON.parse(sort)
    const [skip, take] = JSON.parse(range)

    const [count, proposals] = await repositories.$transaction([
      repositories.proposal.count(),
      repositories.proposal.findMany({
        skip,
        take,
        orderBy: { [field]: order.toLowerCase() },
      }),
    ])

    return reply
      .header('X-Total-Count', count)
      .send(proposals)
  })

  fastify.get('/proposals/:id', async (request: FastifyRequest, reply: FastifyReply) => {
    const { id } = request.params as { id: string }

    const proposal = await repositories.proposal.findFirst({
      where: { id: Number(id) },
    })

    if (!proposal) {
      return reply.status(404).send()
    }

    return proposal
  })
}
