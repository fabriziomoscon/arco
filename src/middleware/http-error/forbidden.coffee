module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 403
    res.data.body.error = (error.message || error || 'forbidden')
    res.data.body.error_code = code if code?

    next()
