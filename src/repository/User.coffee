UserSource = require 'src/source/mongo/User'

UserMapper = require 'src/mapper/User'


class UserRespository


  constructor: (userSource = UserSource, userMapper = UserMapper) ->
    throw new Error 'Invalid source' unless userSource instanceof Function
    throw new Error 'Invalid mapper' unless userMapper.marshall instanceof Function
    @userSource = userSource
    @userMapper = userMapper


  insert: (users, callback) ->
    users = [users] unless Array.isArray users
    @userSource.insert (@userMapper.marshall(user) for user in users), @mapUserCallback(callback)


  findOneById: (userId, callback) ->
    @userSource.findOneById userId, @mapUserCallback(callback)


  findOneByEmail: (email, callback) ->
    @userSource.findOneByEmail email, @mapUserCallback(callback)


  findAll: (callback) ->
    @userSource.findAll (err, cursor) =>
      return callback err, null if err?

      users = []
      cursor.each (err, userData) =>
        return callback err, null if err?
        
        # end of loop
        return callback null, users unless userData?

        users.push @userMapper.unmarshall userData


  update: (userId, user, callback) ->
    @userSource.update userId, @userMapper.marshall(user), @mapUserCallback(callback)


  remove: (userId, callback) ->
    @userSource.remove userId, @mapUserCallback(callback)


  mapUserCallback: (callback) ->
    return (err, usersData) =>
      return callback err, null if err?
      return callback null, null unless usersData?
      usersData = [usersData] unless Array.isArray usersData

      return callback null, (@userMapper.unmarshall(userData) for userData in usersData)


module.exports = UserRespository
