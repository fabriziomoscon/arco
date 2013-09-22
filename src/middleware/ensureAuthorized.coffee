http = require 'src/middleware/httpResponse'

module.exports = (req, res, next) ->
  console.log req.isAuthenticated()
  return next() if req.isAuthenticated()
  return next( http.unauthorized() )
