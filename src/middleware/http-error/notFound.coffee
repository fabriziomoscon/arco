module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 404
    res.data = error: (error.message || error || 'not found')
    res.data.error_code = code if code?
    
    next()
