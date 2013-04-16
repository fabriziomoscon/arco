check = require 'check-types'

class Date

  @marshall: (date) ->

    throw new Error 'Invalid date' unless date instanceof Date
    
    return date.getTime()


  @unmarshall: (timestamp) ->

    throw new Error 'Invalid timestamp' unless check.isPositiveNumber timestamp

    return new Date timestamp


module.exports = Date