ApplicationError = require 'src/lib/error/Application'


module.exports = httpResponse = {

  unauthorized:                require 'src/middleware/http-error/unauthorized'
  notFound:                    require 'src/middleware/http-error/notFound'
  serverError:                 require 'src/middleware/http-error/serverError'
  badRequest:                  require 'src/middleware/http-error/badRequest'
  forbidden:                   require 'src/middleware/http-error/forbidden'
  methodNotAllowed:            require 'src/middleware/http-error/methodNotAllowed'
  proxyAuthenticationRequired: require 'src/middleware/http-error/proxyAuthenticationRequired'

  error: (error) ->

    if error.type is ApplicationError.FORBIDDEN
      return httpResponse.forbidden  error.message, error.code

    if error.type is ApplicationError.BAD_REQUEST
      return httpResponse.badRequest  error.message, error.code

    else
      return httpResponse.serverError error.message, error.code
}
