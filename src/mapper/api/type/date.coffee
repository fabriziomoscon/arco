check = require 'check-types'


marshall = (date) ->

  throw new Error 'Invalid date' unless date instanceof Date
  
  return Math.floor date.getTime()/1000


unmarshall = (timestamp) ->

  throw new Error 'Invalid timestamp' unless check.isPositiveNumber timestamp

  return new Date timestamp


module.exports = {marshall, unmarshall}
