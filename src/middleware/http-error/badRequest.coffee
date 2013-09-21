module.exports = (error) ->

  return (req, res, next) ->

    res.status 400
    res.data.body.error = 'Bad request: ' + (error.message || error)

    next()
