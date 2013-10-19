mongoSource = require 'src/source/mongo/score'

backScoreMapper = require 'src/mapper/score'


class ScoreRespository


  constructor: (scoreSource = mongoSource, scoreMapper = backScoreMapper) ->
    throw new Error 'Invalid source' unless scoreSource?
    throw new Error 'Invalid mapper' unless typeof scoreMapper.marshall is 'function'
    @scoreSource = scoreSource
    @scoreMapper = scoreMapper


  insert: (scores, callback) ->
    scores = [scores] unless Array.isArray scores
    @scoreSource.insert (@scoreMapper.marshall score for score in scores), @mapScoreCallback(callback, false)


  mapScoreCallback: (callback, single = true) ->
    return (err, scoresData) =>
      return callback err, null if err?
      return callback null, null unless scoresData?
      scoresData = [scoresData] unless Array.isArray scoresData

      scores = []
      for scoreData in scoresData
        try scores.push @scoreMapper.unmarshall scoreData
        catch err then return callback err, null

      scores = scores[0] if single

      return callback null, scores


module.exports = ScoreRespository
