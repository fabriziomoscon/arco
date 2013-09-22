module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 500
    res.data.error = (error.message || error || 'server error')
    res.data.error_code = code if code?

    next()
