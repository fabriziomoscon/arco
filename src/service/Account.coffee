check = require 'check-types'
async = require 'async'

UserModel = require 'src/model/User'

UserRepository = require 'src/repository/User'

isValidObjectId = require 'src/validator/type/objectId'

passwordHelper = require 'src/lib/password'


class Account


  constructor: (UserRepo = new UserRepository) ->
    throw new TypeError 'Invalid repository' unless UserRepo?
    @userRepository = UserRepo


  createUser: (user, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error 'Invalid user' unless user instanceof UserModel
    
    async.waterfall [

      (next) =>
        @userRepository.findOneByEmail user.email, (err, userFound) =>
          if err?
            return next err
          if userFound?
            return next new Error 'email already used'
          return next()

      (next) ->
        if user.password?
          passwordHelper.hash user.password, (err, encrypted) ->
            if err?
              return next err
            user.password = encrypted
            return next()
        else
          return next()

      (next) =>
        @userRepository.insert user, (err, users) ->
          if err?
            return next err
          unless users?[0]?
            return next new Error 'No user created'
          return next null, users[0]

    ], (err, user) ->
      if err?
        return callback err

      return callback null, user


  findUserByEmail: (email, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error 'Invalid email' unless typeof email is 'string'
    @userRepository.findOneByEmail email, callback


  findUserById: (userId, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error 'Invalid userId' unless isValidObjectId userId
    @userRepository.findOneById userId, callback


  updateUserById: (userId, user, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error 'Invalid userId' unless isValidObjectId userId
    return callback new Error 'Invalid user' unless user instanceof UserModel

    async.waterfall [

      (next) =>
        if user.email?
          @userRepository.findOneByEmail user.email, (err, userFound) =>
            if err?
              return next err
            if userFound? and userId isnt userFound.id
              return next new Error 'email already used'
            return next()
        else
          return next()

      (next) ->
        if user.password?
          passwordHelper.hash user.password, (err, encrypted) ->
            if err?
              return next err
            user.password = encrypted
            return next()
        else
          return next()

      (next) =>
        return @userRepository.update user, next

    ], (err, user) ->
      if err?
        return callback err
      
      return callback null, user


  findAllUsers: (offset = 0, limit = 20, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new TypeError 'Invalid offset' unless check.isPositiveNumber(offset) or offset is 0
    return callback new TypeError 'Invalid limit' unless check.isPositiveNumber(limit) or limit is 0

    @userRepository.findAll offset, limit, callback


  removeUserById: (userId, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new Error 'Invalid userId' unless isValidObjectId userId

    @userRepository.remove userId, callback


module.exports = Account
