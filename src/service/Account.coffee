UserModel       = require 'src/model/User'
UserRepository  = require 'src/repository/User'
isValidObjectId = require 'src/validator/type/objectId'


class Account


  constructor: (UserRepo = new UserRepository) ->
    throw new Error 'Invalid repository' unless UserRepo?
    @userRepository = UserRepo


  createUser: (user, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid user'), null unless user instanceof UserModel
    
    @userRepository.findOneByEmail user.email, (err, userFound) =>
      return callback err, null if err?
      return callback new Error('email already used'), null if userFound?
      @userRepository.insert user, (err, users) ->
        return callback err, null if err?

        return callback new Error('No user created'), null unless users?[0]?

        return callback null, users[0]
      return
    return


  findUserByEmail: (email, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid email'), null unless typeof email is 'string'
    @userRepository.findOneByEmail email, callback


  findUserById: (userId, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.findOneById userId, callback


  updateUserById: (userId, user, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    return callback new Error('Invalid user'), null unless user instanceof UserModel

    if user.email?
      
      @userRepository.findOneByEmail user.email, (err, userFound) =>
        return callback err, null if err?
        if userFound? and userId isnt userFound.id
          return callback new Error('email already used'), null

        return @userRepository.update userId, user, callback
      return

    else

      return @userRepository.update userId, user, callback


  findAllUsers: (callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    @userRepository.findAll callback


  removeUserById: (userId, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    return callback new Error('Invalid userId'), null unless isValidObjectId userId
    @userRepository.remove userId, callback


module.exports = Account
