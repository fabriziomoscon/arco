module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 401
    res.data = error: (error?.message || error || 'Please sign in to continue')
    res.data.error_code = code if code?

    log.warn res.data.error

    next()
