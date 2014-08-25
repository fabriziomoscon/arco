check = require 'check-types'
async = require 'async'

UserModel = require 'src/model/User'

UserRepository = require 'src/repository/User'

isValidObjectId = require 'src/validator/type/objectId'

passwordHelper = require 'src/lib/password'

ApplicationError = require 'src/lib/error/Application'


class Account


  constructor: (UserRepo = new UserRepository) ->
    unless UserRepo?
      throw new TypeError 'Invalid repository'
    @userRepository = UserRepo


  createUser: (user, callback) ->
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless user instanceof UserModel
      return callback new Error 'Invalid user'
    
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
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless typeof email is 'string'
      return callback new Error 'Invalid email'

    @userRepository.findOneByEmail email, callback


  findUserById: (userId, callback) ->
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless isValidObjectId userId
      return callback new Error 'Invalid userId'

    @userRepository.findOneById userId, callback


  updateUserById: (user, callback) ->
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless user instanceof UserModel
      return callback new Error 'Invalid user'
    unless user.id?
      return callback new Error 'Invalid user id'

    async.waterfall [

      (next) =>
        if user.email?
          @userRepository.findOneByEmail user.email, (err, userFound) =>
            if err?
              return next err
            if userFound? and user.id isnt userFound.id
              return next new ApplicationError 'email already used', 1028, ApplicationError.FORBIDDEN
              # return next new Error 'email already used'
            return next()
        else
          return next()

      # TODO move to another function => single responsibility
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

    ], (err, userUpdated) ->
      if err?
        return callback err
      
      return callback null, userUpdated


  # TODO add constants
  findAllUsers: (offset = 0, limit = 20, callback) ->
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless check.isPositiveNumber(offset) or offset is 0
      return callback new TypeError 'Invalid offset'
    unless check.isPositiveNumber(limit) or limit is 0
      return callback new TypeError 'Invalid limit'

    @userRepository.findAll offset, limit, callback


  removeUserById: (userId, callback) ->
    unless typeof callback is 'function'
      throw new TypeError 'Invalid callback'
    unless isValidObjectId userId
      return callback new Error 'Invalid userId'

    @userRepository.remove userId, callback


module.exports = Account
