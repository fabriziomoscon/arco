module.exports = (error) ->

  return (req, res, next) ->

    res.status 404
    res.data.body.error = 'Not found: ' + (error.message || error)
    
    next()
