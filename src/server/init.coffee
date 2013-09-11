express          = require 'express'
MongoStore       = require('connect-mongo') express
MongoGateway     = require 'src/lib/mongo/Gateway'

getConfig = require 'src/server/config'


module.exports = ->

  console.log 'Loading config: DEFAULT'

  baseDir = @get 'baseDir'

  config = getConfig process.env.NODE_ENV
  @configure process.env.NODE_ENV, require "src/server/environment/#{process.env.NODE_ENV}"

  @set 'port', process.env.PORT || config.server.listenPort

  @use express.bodyParser()
  @use express.methodOverride()
  @use express.cookieParser()
  @use require 'src/middleware/onionware/onion'

  @use (req, res, next) ->
    res.onion.use require 'src/middleware/onionware/format'
    res.onion.use require 'src/middleware/onionware/renderer/json'
    res.onion.use require 'src/middleware/onionware/renderer/html'
    next()

  userAndPassDSN = ''
  if config.db.user? and config.db.password?
    userAndPassDSN = config.db.user + ':' + config.db.password + '@'
  @set 'dsn', config.db.protocol + '://' + userAndPassDSN + config.db.host + ':' + config.db.port + '/' + config.db.dbName
  @set 'port', process.env.PORT || config.server.listenPort
  @set 'sessionSecret', config.server.session.secret

  @set 'facebookAppId', config.server.oauth.facebook.id
  @set 'facebookAppSecret', config.server.oauth.facebook.secret

  @set 'googleAppId', config.server.oauth.google.id
  @set 'googleAppSecret', config.server.oauth.google.secret

  # configure database
  console.log 'Connecting to database: ' + @get 'dsn'
  MongoGateway.setLogger @get('MongoLogger')
  MongoGateway.init config.db
  MongoGateway.connect config.db.user, config.db.password

  # configure session storage
  @set 'sessionStore', new MongoStore url: @get 'dsn'
  @use express.session store: @get('sessionStore'), secret: @get('sessionSecret'), cookie: { httpOnly: false }
