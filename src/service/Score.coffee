ScoreRepository = require 'src/repository/Score'

ScoreModel = require 'src/model/Score'
UserModel  = require 'src/model/User'

isValidObjectId = require 'src/validator/type/objectId'

ApplicationError = require 'src/lib/error/Application'


class Score


  constructor: (ScoreRepo = new ScoreRepository) ->
    throw new Error 'Invalid repository' unless ScoreRepo?
    @scoreRepository = ScoreRepo


  create: (score, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new TypeError 'Invalid score' unless score instanceof ScoreModel

    score.times.created = new Date

    @scoreRepository.insert score, (err, scoresInserted) ->
      if err?
        return callback err
      unless scoresInserted?[0]?
        return callback new Error 'No score created'
      return callback null, scoresInserted[0]
    return


  findOneById: (scoreId, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new TypeError "Invalid score id: #{scoreId}" unless isValidObjectId scoreId

    @scoreRepository.findOneById scoreId, callback


  update: (score, user, callback) ->
    throw new TypeError 'Invalid callback' unless typeof callback is 'function'
    return callback new TypeError 'Invalid score' unless score instanceof ScoreModel
    return callback new TypeError 'Invalid user' unless user instanceof UserModel

    return callback new ApplicationError 'Not allowed', ApplicationError.FORBIDDEN unless score.canEdit user.id

    @scoreRepository.update score, callback


module.exports = Score
