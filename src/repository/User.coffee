mongoSource = require 'src/source/mongo/user'

backUserMapper = require 'src/mapper/user'


class UserRespository


  constructor: (userSource = mongoSource, userMapper = backUserMapper) ->
    throw new Error 'Invalid source' unless userSource?
    throw new Error 'Invalid mapper' unless typeof userMapper.marshall is 'function'
    @userSource = userSource
    @userMapper = userMapper


  insert: (users, callback) ->
    users = [users] unless Array.isArray users
    @userSource.insert (@userMapper.marshall(user) for user in users), @mapUserCallback(callback, false)


  findOneById: (userId, callback) ->
    @userSource.findOneById userId, @mapUserCallback(callback)


  findOneByEmail: (email, callback) ->
    @userSource.findOneByEmail email, @mapUserCallback(callback)


  findAll: (callback) ->
    @userSource.findAll @mapUserCallback(callback, false)


  update: (userId, user, callback) ->
    @userSource.update userId, @userMapper.marshall(user), @mapUserCallback(callback)


  remove: (userId, callback) ->
    @userSource.remove userId, callback


  mapUserCallback: (callback, single = true) ->
    return (err, usersData) =>
      return callback err, null if err?
      return callback null, null unless usersData?
      usersData = [usersData] unless Array.isArray usersData

      users = []
      for userData in usersData
        try users.push @userMapper.unmarshall userData
        catch err then return callback err, null

      users = users[0] if single

      return callback null, users


module.exports = UserRespository
