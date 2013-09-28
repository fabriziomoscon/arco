module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 405
    res.data = error: (error?.message || error || 'method not allowed')
    res.data.error_code = code if code?

    log.warn res.data.error

    next()
