express      = require 'express'
MongoGateway = require 'src/lib/mongo/Gateway'
redisSession = require 'src/middleware/redisSession'

Redis = require 'redis'

config = require 'src/config/environment'


module.exports = ->

  @use express.bodyParser()
  @use express.methodOverride()
  @use express.cookieParser()
  @use redisSession(config)
  @use require 'src/middleware/onionware/onion'

  @use (req, res, next) ->
    res.onion.use require 'src/middleware/onionware/format'
    res.onion.use require 'src/middleware/onionware/renderer/json'
    res.onion.use require 'src/middleware/onionware/renderer/html'
    next()

  if config.db.mongo.user is ''
    config.db.mongo.user = null
  if config.db.mongo.password is ''
    config.db.mongo.password = null

  mongoDBUserPass = ''
  if config.db.mongo.user? and config.db.mongo.password?
    mongoDBUserPass = "#{config.db.mongo.user}:#{config.db.mongo.password}@"

  # configure database
  MongoGateway.setLogger @get('MongoLogger')

  MongoGateway.connect(
    config.db.mongo.host
    config.db.mongo.dbname
    config.db.mongo.port
    {"safe": true}
    config.db.mongo.user
    config.db.mongo.password
  )

  log.info "Connected to mongodb://#{mongoDBUserPass}#{config.db.mongo.host}:#{config.db.mongo.port}/#{config.db.mongo.dbname}"
