passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy

passwordHelper = require 'src/lib/password'

accountService = new (require 'src/service/Account')

logger = log.child {component: "PassportModule"}


module.exports = (config) ->

  passport.serializeUser (user, callback) ->
    callback null, user.id

  passport.deserializeUser (data, callback) ->
    accountService.findUserById data, (err, user) ->
      return callback err, null if err?
      return callback err, false unless user?
      return callback null, user


  passport.use 'local-email', new LocalStrategy( {usernameField: 'email'},
    (email, password, callback) ->
      accountService.findUserByEmail email, (err, user) ->
        return callback null, false, err if err?
        return callback null, false unless user?

        # return callback null, false unless user.status.get() is 'ACTIVE'

        unless user.password?
          logger.info {email:email}, 'user record is missing a password'
          return callback null, false

        passwordHelper.compare password, user.password, (err, result) ->
          return callback null, false, err if err?
          if result is true
            return callback null, user
          return callback null, false
        return

      return
  )

  return passport
