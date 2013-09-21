module.exports = (error) ->

  return (req, res, next) ->

    res.status 407
    res.data.body.error = 'Proxy Authentication required: ' + (error.message || error)
    
    next()
