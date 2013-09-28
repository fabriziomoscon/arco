http = require 'src/middleware/httpResponse'

UserMapper = require 'src/mapper/api/User'

logger = log.child {component: 'AuthController'}


login = (req, res, next) ->

  loginMiddleware = req.passport.authenticate('local-email', (err, user) ->
    if err?
      logger.error {err}
      return next( http.badRequest('Error while logging in', 2001) )

    return next( http.unauthorized('Wrong email or password', 2002) ) unless user

    req.logIn user, (err) ->
      if err?
        logger.error {err:err, user:user}
        return next( http.serverError(err, 2003) )

      try res.data = UserMapper.marshall user
      catch err then return next( http.serverError(err, 1012) )

      return next()
    return
  )

  return loginMiddleware(req, res, next)


module.exports = {login}
