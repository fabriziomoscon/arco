UserModel       = require 'src/model/User'
UserRepository  = require 'src/repository/User'
isValidObjectId = require 'src/validator/type/ObjectId'


class Account


  constructor: (UserRepo = UserRepository) ->
    throw new Error 'Invalid repository' unless UserRepo instanceof Function
    @userRepository = new UserRepo


  createUser: (user, callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    return callback new Error('Invalid User'), null unless user instanceof UserModel
    
    @findUserByEmail user.email, (err, userFound) =>
      return callback err, null if err?
      return callback new Error('email already used'), null if userFound?
      @userRepository.insert user, (err, users) ->
        return callback err, null if err?

        return callback new Error('No user created/returned'), null unless users?[0]?

        return callback null, users[0]
      return
    return


  findUserByEmail: (email, callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    return callback new Error('Invalid email'), null unless typeof email is 'string'
    @userRepository.findOneByEmail email, callback


  findUserById: (userId, callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.findOneById userId, callback


  updateUserById: (userId, user, callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    return callback new Error('Invalid user'), null unless user instanceof UserModel

    if user.email?
      
      @findUserByEmail user.email, (err, userFound) =>
        return callback err, null if err?
        if userFound? and userId isnt userFound.id
          return callback new Error('Email already used'), null

        return @userRepository.update userId, user, callback
      return

    else

      return @userRepository.update userId, user, callback


  findAllUsers: (callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    @userRepository.findAllUsers callback


  removeUserById: (userId, callback) ->
    throw new Error 'Invalid callback' unless callback instanceof Function
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.remove userId, callback


module.exports = Account
