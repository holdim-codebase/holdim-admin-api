import { server } from './server'

server.listen({
  host: '0.0.0.0',
  port: parseInt(process.env.PORT ?? '8080'),
}).catch(error => console.error(error))
