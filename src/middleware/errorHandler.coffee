module.exports = (err, req, res, next) ->

  if typeof err is 'function'
    return err(req, res, next)

  log.error {err}, 'caught by error handler'

  next()
