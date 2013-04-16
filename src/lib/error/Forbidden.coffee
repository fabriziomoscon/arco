class Forbidden extends Error

  constructor: (message) ->
    @message = message
    @name = 'Forbidden'
    super message
    # Error.call @, message
    Error.captureStackTrace @, arguments.callee

module.exports = Forbidden