module.exports = (error) ->

  return (req, res, next) ->

    message = 'Please sign in to continue'
    res.status 401
    res.data.body.error = 'Unauthorized:' + (error.message || error || message)

    next()
