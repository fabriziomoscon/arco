bcrypt = require 'bcrypt'

config = require 'src/config/environment'


hash = (password, callback) ->
  throw new TypeError 'Invalid callback' unless callback instanceof Function
  return callback new TypeError('Invalid password') '' unless typeof password is 'string'
  return callback null, '' if password is ''

  bcrypt.hash password, config.server.auth.saltLength, callback


compare = (password, hash, callback) ->
  throw new TypeError 'Invalid callback' unless callback instanceof Function
  return callback new TypeError 'Invalid password' unless typeof password is 'string'
  return callback new TypeError 'Invalid hash' unless typeof hash is 'string'

  bcrypt.compare password, hash, callback


module.exports = { hash, compare }
