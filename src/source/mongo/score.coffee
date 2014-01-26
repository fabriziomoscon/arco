MongoGateway = require 'src/lib/mongo/Gateway'

objectIdMapper = require 'src/mapper/type/objectId'

SCORES_COLLECTION = 'scores'


module.exports = {

  insert: (scoresData, callback) ->
    MongoGateway.insert SCORES_COLLECTION, scoresData, {}, callback
}
