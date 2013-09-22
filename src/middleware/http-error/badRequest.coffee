module.exports = (error, code) ->

  return (req, res, next) ->

    res.status 400
    res.data.body.error = (error.message || error || 'bad_request')
    res.data.body.error_code = code if code?

    next()
