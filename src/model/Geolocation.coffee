check = require 'check-types'


class Geolocation


  constructor: (lat, long) ->
    @lat = lat
    @long = long


Object.defineProperty Geolocation.prototype, 'lat', {
  get: () -> this._lat
  set: (value) ->
    throw new TypeError 'Invalid latitude' unless check.isNumber(value) and -90 <= value <= 90
    this._lat = value
}

Object.defineProperty Geolocation.prototype, 'long', {
  get: () -> this._long
  set: (value) ->
    throw new TypeError 'Invalid longitude' unless check.isNumber(value) and -180 <= value <= 180
    this._long = value
}


module.exports = Geolocation
