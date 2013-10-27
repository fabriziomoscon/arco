mongoSource = require 'src/source/mongo/score'

backScoreMapper = require 'src/mapper/score'
recordMapper    = require 'src/mapper/record'


class ScoreRespository


  constructor: (scoreSource = mongoSource, scoreMapper = backScoreMapper) ->
    throw new Error 'Invalid source' unless scoreSource?
    throw new Error 'Invalid mapper' unless typeof scoreMapper.marshall is 'function'
    @scoreSource = scoreSource
    @scoreMapper = scoreMapper


  insert: (scores, callback) ->
    scores = [scores] unless Array.isArray scores
    @scoreSource.insert (@scoreMapper.marshall score for score in scores),
      recordMapper(@scoreMapper.unmarshall, callback, false)


module.exports = ScoreRespository
