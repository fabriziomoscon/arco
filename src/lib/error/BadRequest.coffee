class BadRequest extends Error

  constructor: (message) ->
    @message = message
    @name = 'BadRequest'
    super message
    # Error.call @, message
    Error.captureStackTrace @, arguments.callee

module.exports = BadRequest