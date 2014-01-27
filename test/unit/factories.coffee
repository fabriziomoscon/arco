mockUsers = require('test/data/db/user').getData()
mockScores = require('test/data/db/score').getData()

userMapper  = require 'src/mapper/user'
scoreMapper = require 'src/mapper/score'


global.userFactory = (userIndex, unmarshallFunction = userMapper.unmarshall) ->

  throw new Error "user #{userIndex} not found in fixtures" unless mockUsers[userIndex]?

  return unmarshallFunction mockUsers[userIndex]


global.scoreFactory = (scoreIndex, unmarshallFunction = scoreMapper.unmarshall) ->

  throw new Error "score #{scoreIndex} not found in fixtures" unless mockScores[scoreIndex]?

  return unmarshallFunction mockScores[scoreIndex][0]
