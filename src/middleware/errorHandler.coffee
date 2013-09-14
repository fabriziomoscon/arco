module.exports = (err, req, res, next) ->

  if typeof err is 'function'
    return err(req, res, next)

  next()
