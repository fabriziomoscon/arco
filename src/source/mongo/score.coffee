MongoGateway = require 'src/lib/mongo/Gateway'

objectIdMapper = require 'src/mapper/type/objectId'

SCORES_COLLECTION = 'scores'


module.exports = {

  insert: (scoresData, callback) ->
    MongoGateway.insert SCORES_COLLECTION, scoresData, {}, callback


  findOneById: (id, callback) ->
    MongoGateway.findOne SCORES_COLLECTION, {"_id": objectIdMapper.marshall(id)}, {}, callback


  update: (id, scoreData, callback) ->
    id = objectIdMapper.marshall(id)
    MongoGateway.update SCORES_COLLECTION,
      {"_id":id},
      {"$set":scoreData},
      {"multi": false},
      (err, status, info) ->
        return callback err, null if err?
        unless status is 1
          error = new Error "Impossible to update score #{id}"
          log.error {
            message: error.message
            data: scoreData
            info: info
          }
          return callback error, null

        # reinsert the id which gets removed by the mongo gateway
        scoreData._id = id

        return callback null, [scoreData]

}
