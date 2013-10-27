mongoSource = require 'src/source/mongo/user'

backUserMapper = require 'src/mapper/user'
recordMapper   = require 'src/mapper/record'


class UserRespository


  constructor: (userSource = mongoSource, userMapper = backUserMapper) ->
    throw new Error 'Invalid source' unless userSource?
    throw new Error 'Invalid mapper' unless typeof userMapper.marshall is 'function'
    @userSource = userSource
    @userMapper = userMapper


  insert: (users, callback) ->
    users = [users] unless Array.isArray users
    @userSource.insert (@userMapper.marshall(user) for user in users),
      recordMapper(@userMapper.unmarshall, callback, false)


  findOneById: (userId, callback) ->
    @userSource.findOneById userId,
      recordMapper @userMapper.unmarshall, callback


  findOneByEmail: (email, callback) ->
    @userSource.findOneByEmail email,
      recordMapper @userMapper.unmarshall, callback


  findAll: (callback) ->
    @userSource.findAll recordMapper @userMapper.unmarshall, callback, false


  update: (userId, user, callback) ->
    @userSource.update userId,
      @userMapper.marshall(user), recordMapper(@userMapper.unmarshall, callback)


  remove: (userId, callback) ->
    @userSource.remove userId, callback


module.exports = UserRespository
