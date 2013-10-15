http = require 'src/middleware/httpResponse'

check = require 'check-types'

scoreMapper = require 'src/mapper/api/score'


insert = (req, res, next) ->

  return next( http.badRequest('Invalid score data', 3001) ) if check.isEmptyObject req.body
  
  try score = scoreMapper.unmarshallForCreacting req.body
  catch err then return next( http.badRequest('invalid score') )

  #score service insert new score

  return next()

module.exports = {insert}
