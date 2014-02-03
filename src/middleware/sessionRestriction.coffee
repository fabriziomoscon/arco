http = require 'src/middleware/httpResponse'

module.exports = (req, res, next) ->

  return next( http.unauthorized(null, 401) ) unless req.user?.id?
  
  req.params.id = req.user.id

  return next()
