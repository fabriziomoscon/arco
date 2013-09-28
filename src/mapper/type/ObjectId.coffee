ObjectID = require('mongodb').ObjectID

isValidObjectId = require 'src/validator/type/ObjectId'


marshall = (id) ->
  throw new Error 'Invalid id' unless isValidObjectId id
  return ObjectID.createFromHexString id


unmarshall = (objectId) ->
  throw new Error 'Invalid objectId' unless objectId instanceof ObjectID
  return objectId.toHexString()


module.exports = {marshall, unmarshall}
