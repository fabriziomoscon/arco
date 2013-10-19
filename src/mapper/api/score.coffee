check = require 'check-types'

hashMapper = require 'src/mapper/type/hash'

Score = require 'src/model/Score'


marshall = (score) ->

  throw new TypeError 'Invalid score' unless score instanceof Score

  scoreData = {}
  scoreData.id = score.id if score.id?
  scoreData.user_id = score.user_id if score.user_id?
  scoreData.type = score.type if score.type?
  scoreData.total = score.total if score.total?

  scoreData.times = hashMapper.marshall score.times, 'times'
  # scoreData.places = hashMapper.marshall score.places, 'places', placeMapper.marshall
  scoreData.partials = hashMapper.marshall score.partials, 'partials', (number) -> number.valueOf()

  return scoreData


unmarshallForCreating = (data) ->

  throw new TypeError 'Invalid score data' unless check.isObject data
  throw new TypeError 'Invalid score user_id' unless data.user_id?
  throw new TypeError 'Invalid score type' unless data.type?

  score = new Score
  score.setUserId data.user_id
  score.setType data.type

  return score


module.exports = {marshall, unmarshallForCreating}
