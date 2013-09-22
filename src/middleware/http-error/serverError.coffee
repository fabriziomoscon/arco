module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 500
    res.data.body.error = (error.message || error || 'server error')
    res.data.body.error_code = code if code?

    next()
