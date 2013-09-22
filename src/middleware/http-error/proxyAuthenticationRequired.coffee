module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 407
    res.data.error = (error.message || error || 'proxy authentication required')
    res.data.error_code = code if code?
    
    next()
