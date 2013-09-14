require('rootpath')()

http = require 'http'

config = require 'src/config/environment'

global.log = require 'src/middleware/logger/log'

redisConnect = require 'src/lib/redis/connect'

redisConnect config, log.child({component: 'Redis'}), (err) ->
  throw err if err?

  server = http.createServer require('src/server/init')(config)
  server.listen config.server.api.listenPort, config.server.api.listenHost, () ->
    log.info {server: server.address()}, 'listening'
