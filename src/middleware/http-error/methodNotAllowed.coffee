module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 405
    res.data.body.error = (error.message || error || 'method not allowed')
    res.data.body.error_code = code if code?

    next()
