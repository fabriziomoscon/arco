http = require 'src/middleware/httpResponse'

apiUserMapper = require 'src/mapper/api/user'

logger = log.child {component: 'AuthController'}


module.exports = {


  login: (req, res, next) ->

    loginMiddleware = req.passport.authenticate('local-email', (err, user) ->
      if err?
        logger.error {err}
        return next( http.badRequest('Error while logging in', 2001) )

      unless user
        return next( http.unauthorized('Wrong email or password', 2002) )

      req.logIn user, (err) ->
        if err?
          logger.error {err:err, user:user}
          return next( http.serverError(err, 2003) )

        try res.data = apiUserMapper.marshall user
        catch err then return next( http.serverError(err, 1012) )

        return next()
      return
    )

    return loginMiddleware(req, res, next)


}
