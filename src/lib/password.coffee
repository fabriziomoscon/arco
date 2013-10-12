bcrypt = require 'bcrypt'

config = require 'src/config/environment'


hash = (password, callback) ->
  throw new TypeError 'Invalid callback' unless typeof callback is 'function'
  return callback new TypeError('Invalid password') '' unless typeof password is 'string'
  return callback null, '' if password is ''

  return bcrypt.hash password, config.server.auth.saltLength, callback


hashSync = (password) ->
  throw new TypeError 'Invalid password' unless typeof password is 'string'
  return '' if password is ''
  return bcrypt.hashSync(password, config.server.auth.saltLength)


compare = (password, hash, callback) ->
  throw new TypeError 'Invalid callback' unless typeof callback is 'function'
  return callback new TypeError 'Invalid password' unless typeof password is 'string'
  return callback new TypeError 'Invalid hash' unless typeof hash is 'string'

  return bcrypt.compare password, hash, callback


module.exports = { hash, hashSync, compare }
