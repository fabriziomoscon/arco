module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 405
    res.data.body.error = 'Method not allowed: ' + (error.message || error)
    res.data.body.error_code = code if code?

    next()
