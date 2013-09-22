class ApplicationError

  @FORBIDDEN = 1
  @BAD_REQUEST = 2


  constructor: (@message, @code, @type) ->


module.exports = ApplicationError
