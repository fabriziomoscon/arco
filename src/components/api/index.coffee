require('rootpath')()

http = require 'http'

async = require 'async'

config = require 'src/config/environment'

global.log = require 'src/middleware/logger/log'

redisService = require 'src/lib/services/redis'
mongoService = require 'src/lib/services/mongo'


async.auto {

  mongo: (cb)->
    mongoService config, log.child({component: 'Mongo'}), cb

  redis: (cb)->
    redisService config, log.child({component: 'Redis'}), cb

}, (err, infraServices) ->
  if err?
    throw err

  services = {
    account: new (require 'src/service/Account')
    score: new (require 'src/service/Score')
  }

  app = require('src/components/api/app')(config, services)

  httpLogger = log.child {component: 'HttpServer'}

  server = http.createServer app
  server.listen config.server.api.listenPort, config.server.api.listenHost, () ->
    httpLogger.info {server: server.address()}, 'listening'
