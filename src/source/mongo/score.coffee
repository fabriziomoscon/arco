MongoGateway = require 'src/lib/mongo/Gateway'

objectIdMapper = require 'src/mapper/type/objectId'

collectionName = 'scores'


insert = (scoresData, callback) ->
  MongoGateway.insert collectionName, scoresData, {}, callback


module.exports = {insert}
