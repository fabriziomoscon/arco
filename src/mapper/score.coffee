check = require 'check-types'
Hash = require 'node-hash'

objectIdMapper = require 'src/mapper/type/objectId'

ScoreModel = require 'src/model/Score'
Place      = require 'src/model/Place'


placeMapper = require 'src/mapper/place'


marshall = (score) ->
  throw new Error 'Invalid score' unless score instanceof ScoreModel

  data = {}

  data._id = objectIdMapper.marshall score.id if score.id?
  data.type = score.type if score.type?
  data.user_id = objectIdMapper.marshall score.user_id if score.user_id?
  data.times = score.times.marshall()
  data.places = score.places.marshall placeMapper.marshall
  data.partials = score.partials.marshall()

  return data


unmarshall = (data) ->
  throw new Error 'Invalid data' unless check.isObject data

  score = new ScoreModel

  score.setId objectIdMapper.unmarshall data._id if data._id?
  score.setType data.type if data.type?
  score.setUserId objectIdMapper.unmarshall data.user_id if data.user_id?

  score.times = Hash.unmarshall data.times, Hash.comparator.Date
  score.places = Hash.unmarshall data.places, ((v) -> v instanceof Place), placeMapper.marshall
  score.partials = Hash.unmarshall data.partials, Hash.comparator.number

  return score


module.exports = {marshall, unmarshall}
