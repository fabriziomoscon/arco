MongoGateway = require 'src/lib/mongo/Gateway'

objectIdMapper = require 'src/mapper/type/objectId'

collectionName = 'users'


insert = (userData, callback) ->
  MongoGateway.insert collectionName, userData, {}, callback


findOneById = (id, callback) =>
  options = {}
  MongoGateway.findOne collectionName, {"_id": objectIdMapper.marshall(id)}, options, callback


findOneByEmail = (email, callback) =>
  options = {}
  MongoGateway.findOne collectionName, {"email": email}, options, callback


findAll = (callback) ->
  whereQuery = {}
  fields = {}
  options = {}
  MongoGateway.find collectionName, whereQuery, fields, options, (err, cursor) ->
    return callback err, null if err?
    return cursor.toArray callback


remove = (id, callback) ->
  MongoGateway.findAndModify collectionName,
    {"_id": objectIdMapper.marshall(id)},
    [],
    {},
    {"new": false},
    callback


update = (id, userData, callback) ->
  id = objectIdMapper.marshall(id)
  MongoGateway.update collectionName,
    {"_id":id},
    {"$set":userData},
    {"multi": false},
    (err, status, info) ->
      return callback err, null if err?
      unless status is 1
        error = new Error "Impossible to update user #{id}"
        log.error {
          message: error.message
          data: userData
          info: info
        }
        return callback error, null

      # reinsert the id which gets removed by the mongo gateway
      userData._id = id

      return callback null, [userData]


module.exports = {insert, findOneById, findOneByEmail, findAll, remove, update}
