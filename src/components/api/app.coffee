express = require 'express'
cors    = require 'cors'

redisSession = require 'src/middleware/redisSession'

passportLib = require 'src/lib/passport'

apiRoutes = require('src/components/api/routes')

authController  = require 'src/controller/auth'
scoreController = require 'src/controller/score'
userController  = require 'src/controller/user'
testController  = require 'src/controller/test'


module.exports = (config, services) ->

  app = express()

  app.disable 'x-powered-by'

  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use redisSession(config)
  app.use cors(origin: true, credentials: true)

  passport = passportLib config

  app.use passport.initialize()
  app.use passport.session()
  app.use (req, res, next) ->
    req.passport = passport
    next()

  controllers = {
    auth:  authController()
    score: scoreController services.score
    user:  userController services.account
    test:  testController()
  }

  app.use apiRoutes(config, controllers, passport).middleware

  app.use require 'src/middleware/errorHandler'

  app.use (req, res, next) ->
    if res.statusCode is 204 or res.data?
      return res.format(
        json: () -> res.json res.data
      )
    return next()

  return app
