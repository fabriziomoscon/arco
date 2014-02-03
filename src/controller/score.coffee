check = require 'check-types'

http = require 'src/middleware/httpResponse'

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

# --------------------------

edit = (req, res, next) ->

  return next( http.badRequest('Invalid score data', 3001) ) if check.isEmptyObject req.body

  scoreService.findOneById req.params.id, (err, scoreFound) ->
    return next( http.error(err, 3010) ) if err?

    return next( http.notFound('score not found', 3011) ) unless scoreFound?

    try score = apiScoreMapper.unmarshallForEditing req.body, scoreFound
    catch err then return next( http.badRequest('invalid score', 3002) )    

    scoreService.edit score, req.user, (err, scoreEdited) ->
      return next( http.error(err, 3010) ) if err?

      try res.data = apiScoreMapper.marshall scoreEdited
      catch err then return next( http.serverError(err, 3004) )

      res.status 200

      return next()
    return
  return



module.exports = {
  create
  edit
}
