module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 403
    res.data = error: (error?.message || error || 'forbidden')
    res.data.error_code = code if code?

    log.warn res.data.error

    next()
