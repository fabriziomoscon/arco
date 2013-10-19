ScoreRepository = require 'src/repository/Score'
ScoreModel      = require 'src/model/Score'

class Score


  constructor: (ScoreRepo = new ScoreRepository) ->
    throw new Error 'Invalid repository' unless ScoreRepo?
    @scoreRepository = ScoreRepo


  create: (score, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new TypeError 'Invalid score' unless score instanceof ScoreModel

    score.times.set 'created_at', new Date

    @scoreRepository.insert score, (err, scoresInserted) ->
      return callback err, null if err?
      return callback new Error('No score created'), null unless scoresInserted?[0]?
      return callback null, scoresInserted[0]
    return


module.exports = Score
