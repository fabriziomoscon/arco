http = require 'src/middleware/httpResponse'

check = require 'check-types'

apiScoreMapper = require 'src/mapper/api/score'

scoreService = new (require 'src/service/Score')


create = (req, res, next) ->

  return next( http.badRequest('Invalid score data', 3001) ) if check.isEmptyObject req.body

  req.body.user_id = req.user.id

  try score = apiScoreMapper.unmarshallForCreating req.body
  catch err then return next( http.badRequest('invalid score', 3002) )

  scoreService.create score, (err, scoreInserted) ->
    return next( http.error(err, 3003) ) if err?

    try res.data = apiScoreMapper.marshall scoreInserted
    catch err then return next( http.serverError(err, 3004) )

    res.status 201

    return next()
  return


module.exports = {create}
