check = require 'check-types'

class Geolocation


  constructor: (lat, long) ->
    @setLat lat
    @setLong long


  setLat: (lat) ->
    throw new Error 'Invalid lat' unless check.isNumber(lat) and lat <= 90 and lat >= -90
    @lat = lat


  setLong: (long) ->
    throw new Error 'Invalid long' unless check.isNumber(long) and long <= 180 and long >= -180
    @long = long


module.export = Geolocation