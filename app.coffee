require('rootpath')()

config = require 'src/config/environment'

global.log = require 'src/middleware/logger/log'

redisConnect = require 'src/lib/redis/connect'

redisConnect config, log.child({component: 'Redis'}), (err) ->
  throw err if err?

  path    = require 'path'
  express = require 'express'
  http = require 'http'
  # https = require 'https'

  app = express()
  server = http.createServer app

  app.set 'baseDir', require('path').resolve __dirname

  app.configure require 'src/server/init'
  app.configure require 'src/server/routes'

  # Far better error stack debugging. Do not use in production!
  if process.env.NODE_ENV is 'development'

    # Breakdown
    breakdown = require 'breakdown'
    app.use (err, req, res, next) ->
      breakdown err
      res.writeHead 500, 'Content-Type': 'text/plain'
      res.end err.stack

  server.listen config.server.api.listenPort, config.server.api.listenHost, () ->
    log.info {server: server.address()}, 'listening'
