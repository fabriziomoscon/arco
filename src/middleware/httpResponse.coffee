Forbidden  = require 'src/lib/error/Forbidden'
BadRequest = require 'src/lib/error/BadRequest'


module.exports = httpResponse = {

  unauthorized:                require 'src/middleware/http-error/unauthorized'
  notFound:                    require 'src/middleware/http-error/notFound'
  serverError:                 require 'src/middleware/http-error/serverError'
  badRequest:                  require 'src/middleware/http-error/badRequest'
  forbidden:                   require 'src/middleware/http-error/forbidden'
  methodNotAllowed:            require 'src/middleware/http-error/methodNotAllowed'
  proxyAuthenticationRequired: require 'src/middleware/http-error/proxyAuthenticationRequired'

  error: (error) ->

    if error instanceof Forbidden
      return httpResponse.forbidden error

    if error instanceof BadRequest
      return httpResponse.badRequest error

    else
      return httpResponse.serverError error
}
