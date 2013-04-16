MongoGateway = require 'src/lib/mongo/Gateway'

ObjectIdMapper = require 'src/mapper/type/ObjectId'

collectionName = 'users'

class UserSource

  @insert: (userData, callback) ->
    MongoGateway.insert collectionName, userData, {}, callback


  @findOneById: (id, callback) =>
    options = {}
    MongoGateway.findOne collectionName, {"_id":ObjectIdMapper.marshall(id)}, options, callback


  @findOneByEmail: (email, callback) =>
    options = {}
    MongoGateway.findOne collectionName, {"email":email}, options, callback


  @findAll: (callback) ->
    whereQuery = {}
    fields = {}
    options = {}
    MongoGateway.find collectionName, whereQuery, fields, options, callback


  @remove: (id, callback) ->
    MongoGateway.findAndModify collectionName,
      {"_id": ObjectIdMapper.marshall(id)},
      [],
      {},
      {"new": false},
      callback


  @update: (id, userData, callback) ->
    options = multi: false
    MongoGateway.update collectionName, {"_id":ObjectIdMapper.marshall(id)}, {$set:userData}, options, callback


module.exports = UserSource