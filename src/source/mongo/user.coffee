MongoGateway = mongoGateway

objectIdMapper = require 'src/mapper/type/objectId'

USERS_COLLECTION = 'users'


module.exports = {

  insert: (userData, callback) ->
    MongoGateway.insert USERS_COLLECTION, userData, {}, callback


  findOneById: (id, callback) ->
    MongoGateway.findOne USERS_COLLECTION, {"_id": objectIdMapper.marshall(id)}, {}, callback


  findOneByEmail: (email, callback) ->
    MongoGateway.findOne USERS_COLLECTION, {"email": email}, {}, callback


  findAll: (offset, limit, callback) ->
    return MongoGateway.db.collection(USERS_COLLECTION).find(
      {}
      {}
      {"limit": limit, "skip": offset }
      _handleManyDocuments(callback)
    )


  remove: (id, callback) ->
    MongoGateway.findAndModify USERS_COLLECTION,
      {"_id": objectIdMapper.marshall(id)},
      [],
      {},
      {"new": false},
      callback


  update: (id, userData, callback) ->
    id = objectIdMapper.marshall(id)
    MongoGateway.update USERS_COLLECTION,
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

}


_handleManyDocuments = (callback) ->
  return (err, cursor) ->

    stream = cursor.stream()

    documents = []

    stream.on 'error', (err) -> return callback err
    stream.on 'data', (doc) -> documents.push doc
    stream.on 'end', () ->
    stream.on 'close', () -> return callback null, documents
