Forbidden  = require 'src/lib/error/Forbidden'
BadRequest = require 'src/lib/error/BadRequest'

class HttpErrors

  @unauthorized:                require 'src/middleware/onionware/http-error/unauthorized'
  @notFound:                    require 'src/middleware/onionware/http-error/notFound'
  @serverError:                 require 'src/middleware/onionware/http-error/serverError'
  @badRequest:                  require 'src/middleware/onionware/http-error/badRequest'
  @forbidden:                   require 'src/middleware/onionware/http-error/forbidden'
  @methodNotAllowed:            require 'src/middleware/onionware/http-error/methodNotAllowed'
  @proxyAuthenticationRequired: require 'src/middleware/onionware/http-error/proxyAuthenticationRequired'

  @error: (error) ->

    if error instanceof Forbidden

      return HttpErrors.forbidden error

    if error instanceof BadRequest

      return HttpErrors.badRequest error

    else

      return HttpErrors.serverError error

module.exports = HttpErrors