http = require 'src/middleware/httpResponse'

module.exports = (req, res, next) ->
  return next() if req.isAuthenticated()
  return next( http.unauthorized(null, 401) )
