http = require 'src/middleware/httpResponse'

module.exports = (action) ->

  return (req, res, next) ->

    return next( http.unauthorized(null, 401) ) unless req.user?.id?
    
    req.params.id = req.user.id
    return action req, res, next
