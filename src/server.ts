import fastifyFactory from 'fastify'
import fastifyView from '@fastify/view'
import fastifyFormBody from '@fastify/formbody'
import fastifyBasicAuth from '@fastify/basic-auth'
import cors from '@fastify/cors'
import ejs from 'ejs'
import path from 'path'

import { QuickLookController } from './routes/QuickLookController'
import { AdminPanelController } from './routes/AdminPanelController'

import { logger } from './logging'

export const fastify = fastifyFactory({ logger })

void fastify.register(cors, {
  exposedHeaders: ['X-Total-Count'],
})
void fastify.register(fastifyView, {
  engine: {
    ejs,
  },
  root: path.join(__dirname, 'templates'),
})
void fastify.register(fastifyFormBody)

// Controller: Quick Look (Telegram Bot)
void fastify.register(QuickLookController)

// Basic Auth
void fastify.register(fastifyBasicAuth, {
  validate: async (username, password) => {
    if (username !== 'admin' || password !== 'loh') {
      return new Error('Not authorized')
    }
  },
})

// Controller: Admin Dashboard API
void fastify.register(AdminPanelController, { prefix: '/v1' })

export const server = fastify
