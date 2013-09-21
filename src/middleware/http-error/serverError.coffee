module.exports = (error) ->

  return (req, res, next) ->

    res.status 500
    res.data.body.error = 'Server error: ' + (error.message || error)

    next()
