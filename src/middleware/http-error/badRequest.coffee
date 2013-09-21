module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 400
    res.data.body.error = 'Bad request: ' + (error.message || error)
    res.data.body.error_code = code if code?

    next()
