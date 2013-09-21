module.exports = (error) ->

  return (req, res, next) ->

    res.status 405
    res.data.body.error = 'Method not allowed: ' + (error.message || error)

    next()
