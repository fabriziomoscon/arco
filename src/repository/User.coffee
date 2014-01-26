mongoSource = require 'src/source/mongo/user'

backUserMapper = require 'src/mapper/user'
documentMapper = require 'src/mapper/document'


class UserRespository


  constructor: (userSource = mongoSource, userMapper = backUserMapper) ->
    throw new Error 'Invalid source' unless userSource?
    throw new Error 'Invalid mapper' unless typeof userMapper.marshall is 'function'
    @userSource = userSource
    @userMapper = userMapper


  insert: (users, callback) ->
    users = [users] unless Array.isArray users
    @userSource.insert (@userMapper.marshall(user) for user in users),
      documentMapper(@userMapper.unmarshall, callback, false)


  findOneById: (userId, callback) ->
    @userSource.findOneById userId,
      documentMapper @userMapper.unmarshall, callback


  findOneByEmail: (email, callback) ->
    @userSource.findOneByEmail email,
      documentMapper @userMapper.unmarshall, callback


  findAll: (offset, limit, callback) ->
    @userSource.findAll(
      offset
      limit
      documentMapper(@userMapper.unmarshall, callback, false)
    )


  update: (userId, user, callback) ->
    @userSource.update userId,
      @userMapper.marshall(user), documentMapper(@userMapper.unmarshall, callback)


  remove: (userId, callback) ->
    @userSource.remove userId, callback


module.exports = UserRespository
