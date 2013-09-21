module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 407
    res.data.body.error = 'Proxy Authentication required: ' + (error.message || error)
    res.data.body.error_code = code if code?
    
    next()
