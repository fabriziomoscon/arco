module.exports = (error) ->

  return (req, res, next) ->

    res.status 403
    res.data.body.error = 'Forbidden: ' + (error.message || error)

    next()
