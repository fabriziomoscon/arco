check = require 'check-types'
Hash = require 'node-hash'

apiDateMapper = require 'src/mapper/api/type/date'
#apiPlaceMapepr = require 'src/mapper/api/place'

Score = require 'src/model/Score'


module.exports = {


  marshall: (score) ->

    throw new TypeError 'Invalid score' unless score instanceof Score

    scoreData = {}
    scoreData.id = score.id if score.id?
    scoreData.user_id = score.user_id if score.user_id?
    scoreData.type = score.type if score.type?
    scoreData.total = score.total if score.total?

    scoreData.times = score.times.marshall apiDateMapper.marshall
    # scoreData.places = score.places.marshall apiPlaceMapper.marshall
    scoreData.arrows = score.arrows.marshall()

    return scoreData


  unmarshallForCreating: (data) ->

    throw new TypeError 'Invalid score data' unless check.isObject data

    score = new Score data.type
    score.user_id = data.user_id
    if data.arrows? and check.isObject(data.arrows)
      score.arrows = Hash.unmarshall data.arrows, Hash.comparator.Array
    else
      if data.total?
        score.total = parseInt(data.total, 10)

    return score


  unmarshallForEditing: (data, existingScore) ->

    throw new TypeError 'Invalid score data' unless check.isObject data
    throw new TypeError 'Invalid score' unless score instanceof Score

    if data.arrows? and check.isObject(data.arrows)
      score.arrows = Hash.unmarshall data.arrows, Hash.comparator.Array
    else
      if data.total?
        score.total = parseInt(data.total, 10)

    return score


}
