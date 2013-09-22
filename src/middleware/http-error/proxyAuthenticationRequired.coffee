module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 407
    res.data.body.error = (error.message || error || 'proxy authentication required')
    res.data.body.error_code = code if code?
    
    next()
