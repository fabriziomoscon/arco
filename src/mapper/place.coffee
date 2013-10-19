objectIdMapper = require 'src/mapper/type/objectId'

PlaceModel = require 'src/model/Place'

geolocationMapper = require 'src/mapper/geolocation'

check = require 'check-types'


marshall = (place) ->

  throw new Error 'Invalid place' unless place instanceof PlaceModel

  data = {}

  data._id = objectIdMapper.marshall place.id if place.id?
  data.geolocation = geolocationMapper.marshall place.geolocation
  data.country = place.country if place.country?
  data.city = place.city if place.city?

  return data


unmarshall = (data) ->

  throw new Error 'Invalid data' unless check.isObject data

  place = new PlaceModel geolocationMapper.unmarshall data.geolocation

  place.setId objectIdMapper.unmarshall data._id if data._id?
  place.setCountry data.country if data.country?
  place.setCity data.city if data.city?

  return place


module.exports = {marshall, unmarshall}
