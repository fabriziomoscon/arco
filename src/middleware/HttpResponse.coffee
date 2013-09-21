Forbidden  = require 'src/lib/error/Forbidden'
BadRequest = require 'src/lib/error/BadRequest'

class HttpResponse

  @unauthorized:                require 'src/middleware/http-error/unauthorized'
  @notFound:                    require 'src/middleware/http-error/notFound'
  @serverError:                 require 'src/middleware/http-error/serverError'
  @badRequest:                  require 'src/middleware/http-error/badRequest'
  @forbidden:                   require 'src/middleware/http-error/forbidden'
  @methodNotAllowed:            require 'src/middleware/http-error/methodNotAllowed'
  @proxyAuthenticationRequired: require 'src/middleware/http-error/proxyAuthenticationRequired'

  @error: (error) ->

    if error instanceof Forbidden

      return HttpResponse.forbidden error

    if error instanceof BadRequest

      return HttpResponse.badRequest error

    else

      return HttpResponse.serverError error

module.exports = HttpResponse
