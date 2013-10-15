check = require 'check-types'

Score = require 'src/model/Score'


unmarshallForCreating = (data) ->

  throw new TypeError 'Invalid score data' unless check.isObject data
  throw new TypeError 'Invalid score user_id' unless data.user_id?
  throw new TypeError 'Invalid score type' unless data.type?

  score = new Score
  score.setUserId data.user_id
  score.setType data.type

  return score


module.exports = {unmarshallForCreating}
