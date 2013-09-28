passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy

passwordHelper = require 'src/lib/password'

accountService = new (require 'src/service/Account')

logger = log.child {component: "PassportModule"}


module.exports = (config) ->

  passport.serializeUser (user, callback) ->
    callback null, user.id

  passport.deserializeUser (data, callback) ->
    accountService.findUserById data, (err, users) ->
      return callback err, null if err?
      return callback err, false unless users?[0]?
      return callback null, users[0]


  passport.use 'local-email', new LocalStrategy( {usernameField: 'email'},
    (email, password, callback) ->
      accountService.findUserByEmail email, (err, users) ->
        return callback err, false if err?
        return callback null, false unless users?[0]?

        user = users[0]

        # return callback null, false unless user.status.get() is 'ACTIVE'

        unless user.password?
          logger.info {email:email}, 'user record is missing a password'
          return callback null, false

        passwordHelper.compare password, user.password, (err, result) ->
          return callback err, false if err?
          unless result is true
            return callback null, false
          return callback null, user
        return

      return
  )

  return passport
