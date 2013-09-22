MongoGateway = require 'src/lib/mongo/Gateway'
redisSession = require 'src/middleware/redisSession'

express = require 'express'
Redis   = require 'redis'


module.exports = (config) ->

  app = express()

  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use redisSession(config)

  if config.db.mongo.user is ''
    config.db.mongo.user = null
  if config.db.mongo.password is ''
    config.db.mongo.password = null

  mongoDBUserPass = ''
  if config.db.mongo.user? and config.db.mongo.password?
    mongoDBUserPass = "#{config.db.mongo.user}:#{config.db.mongo.password}@"

  # configure database
  MongoGateway.setLogger app.get('MongoLogger')

  MongoGateway.connect(
    config.db.mongo.host
    config.db.mongo.dbname
    config.db.mongo.port
    {"safe": true}
    config.db.mongo.user
    config.db.mongo.password
  )

  log.info "Connected to mongodb://#{mongoDBUserPass}#{config.db.mongo.host}:#{config.db.mongo.port}/#{config.db.mongo.dbname}"

  app.use (req, res, next) ->
    res.data = {}
    next()

  app.use require('src/server/routes').middleware
  
  app.use require 'src/middleware/errorHandler'
  app.use (req, res, next) ->
    res.format(
      json: () -> res.json res.data
    )


  # # Far better error stack debugging. Do not use in production!
  # if process.env.NODE_ENV is 'development'

  #   # Breakdown
  #   breakdown = require 'breakdown'
  #   app.use (err, req, res, next) ->
  #     breakdown err
  #     res.writeHead 500, 'Content-Type': 'text/plain'
  #     res.end err.stack


  return app
