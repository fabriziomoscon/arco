check = require 'check-types'

http = require 'src/middleware/httpResponse'

apiScoreMapper = require 'src/mapper/api/score'


module.exports = (scoreService) ->

  return {

    create: (req, res, next) ->

      if check.isEmptyObject req.body
        return next( http.badRequest('Invalid score data', 3001) )

      req.body.user_id = req.user.id

      try score = apiScoreMapper.unmarshallForCreating req.body
      catch err then return next( http.badRequest('invalid score', 3002) )

      scoreService.create score, (err, scoreInserted) ->
        if err?
          return next( http.error(err, 3003) )

        try res.data = apiScoreMapper.marshall scoreInserted
        catch err then return next( http.serverError(err, 3004) )

        res.status 201

        return next()
      return


    edit: (req, res, next) ->

      if check.isEmptyObject req.body
        return next( http.badRequest('Invalid score data', 3001) )

      scoreService.findOneById req.params.id, (err, scoreFound) ->
        if err?
          return next( http.error(err, 3010) )

        unless scoreFound?
          return next( http.notFound('score not found', 3011) )

        try score = apiScoreMapper.unmarshallForEditing req.body, scoreFound
        catch err then return next( http.badRequest('invalid score', 3002) )    

        scoreService.edit score, req.user, (err, scoreEdited) ->
          if err?
            return next( http.error(err, 3010) )

          try res.data = apiScoreMapper.marshall scoreEdited
          catch err then return next( http.serverError(err, 3004) )

          res.status 200

          return next()
        return
      return

  }
