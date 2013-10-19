objectIdMapper = require 'src/mapper/type/objectId'
hashMapper     = require 'src/mapper/type/hash'

ScoreModel = require 'src/model/Score'

check = require 'check-types'

placeMapper = require 'src/mapper/place'


marshall = (score) ->
  throw new Error 'Invalid score' unless score instanceof ScoreModel

  data = {}

  data._id = objectIdMapper.marshall score.id if score.id?
  data.type = score.type if score.type?
  data.user_id = objectIdMapper.marshall score.user_id if score.user_id?
  data.times = hashMapper.marshall score.times, 'times'
  data.places = hashMapper.marshall score.places, 'places', placeMapper.marshall
  data.partials = hashMapper.marshall score.partials, 'partials', (number) -> number.valueOf()

  return data


unmarshall = (data) ->
  throw new Error 'Invalid data' unless check.isObject data

  score = new ScoreModel

  score.setId objectIdMapper.unmarshall data._id if data._id?
  score.setType data.type if data.type?
  score.setUserId objectIdMapper.unmarshall data.user_id if data.user_id?

  hashMapper.unmarshall data.times, score.times
  hashMapper.unmarshall data.places, score.places, placeMapper.marshall
  hashMapper.unmarshall data.partials, score.partials, (number) -> new Number number

  return score


module.exports = {marshall, unmarshall}
