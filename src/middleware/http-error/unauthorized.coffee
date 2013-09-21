module.exports = (error, code) ->

  return (req, res, next) ->

    message = 'Please sign in to continue'
    res.status 401
    res.data.body.error = 'Unauthorized:' + (error.message || error || message)
    res.data.body.error_code = code if code?

    next()
