check = require 'check-types'

class Geolocation


  constructor: (lat, long) ->
    @setLat lat
    @setLong long


  setLat: (lat) ->
    throw new TypeError 'Invalid latitude' unless check.isNumber(lat) and -90 <= lat <= 90
    @lat = lat


  setLong: (long) ->
    throw new TypeError 'Invalid longitude' unless check.isNumber(long) and -180 <= long <= 180
    @long = long


module.exports = Geolocation
