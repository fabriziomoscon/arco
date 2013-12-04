Geolocation = require 'src/model/Geolocation'
isValidObjectId = require 'src/validator/type/objectId'


class Place


  constructor: (geolocation) ->
    @geolocation = geolocation


Object.defineProperty Place.prototype, 'id', {
  get: () -> this._id
  set: (value) ->
    throw new TypeError 'Invalid id' unless isValidObjectId value
    this._id = value
}

Object.defineProperty Place.prototype, 'geolocation', {
  get: () -> this._geolocation
  set: (value) ->
    throw new TypeError 'Invalid geolocation' unless value instanceof Geolocation
    this._geolocation = value
}

Object.defineProperty Place.prototype, 'country', {
  get: () -> this._country
  set: (value) ->
    throw new TypeError 'Invalid country' unless typeof value is 'string'
    this._country = value
}

Object.defineProperty Place.prototype, 'city', {
  get: () -> this._city
  set: (value) ->
    throw new TypeError 'Invalid city' unless typeof value is 'string'
    this._city = value
}


module.exports = Place
