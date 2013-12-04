async = require 'async'

UserModel       = require 'src/model/User'
UserRepository  = require 'src/repository/User'
isValidObjectId = require 'src/validator/type/objectId'
passwordHelper  = require 'src/lib/password'


class Account


  constructor: (UserRepo = new UserRepository) ->
    throw new TypeError 'Invalid repository' unless UserRepo?
    @userRepository = UserRepo


  createUser: (user, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid user'), null unless user instanceof UserModel
    
    async.waterfall [

      (next) =>
        @userRepository.findOneByEmail user.email, (err, userFound) =>
          return next err, null if err?
          return next new Error('email already used'), null if userFound?
          return next()

      (next) ->
        if user.password?
          passwordHelper.hash user.password, (err, encrypted) ->
            return next err, null if err?
            user.password = encrypted
            return next()
        else
          return next()

      (next) =>
        @userRepository.insert user, (err, users) ->
          return next err, null if err?
          return next new Error('No user created'), null unless users?[0]?
          return next null, users[0]

    ], (err, user) ->
      return callback err, null if err?

      return callback null, user


  findUserByEmail: (email, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid email'), null unless typeof email is 'string'
    @userRepository.findOneByEmail email, callback


  findUserById: (userId, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.findOneById userId, callback


  updateUserById: (userId, user, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    return callback new Error('Invalid user'), null unless user instanceof UserModel

    async.waterfall [

      (next) =>
        if user.email?
          @userRepository.findOneByEmail user.email, (err, userFound) =>
            return next err, null if err?
            if userFound? and userId isnt userFound.id
              return next new Error('email already used'), null
            return next()
        else
          return next()

      (next) ->
        if user.password?
          passwordHelper.hash user.password, (err, encrypted) ->
            return next err, null if err?
            user.password = encrypted
            return next()
        else
          return next()

      (next) =>
        return @userRepository.update userId, user, next

    ], (err, user) ->
      return callback err, null if err?
      
      return callback null, user


  findAllUsers: (callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    @userRepository.findAll callback


  removeUserById: (userId, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.remove userId, callback


module.exports = Account
