module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 400
    res.data = error: (error?.message || error || 'bad_request')
    res.data.error_code = code if code?

    log.warn res.data.error

    next()
