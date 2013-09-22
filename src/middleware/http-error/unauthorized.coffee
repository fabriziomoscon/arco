module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 401
    res.data.body.error = (error.message || error || 'Please sign in to continue')
    res.data.body.error_code = code if code?

    next()
