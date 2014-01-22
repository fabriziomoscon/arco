check = require 'check-types'

geolocationModel = require 'src/model/Geolocation'


marshall = (geolocation) ->

  throw new Error 'Invalid geolocation' unless geolocation instanceof geolocationModel

  return {
    type: 'Point'
    coordinates: [geolocation.long, geolocation.lat]
  }


unmarshall = (data) ->

  throw new Error 'Invalid geolocation data' unless check.isObject data

  return new geolocationModel data.coordinates[0], data.coordinates[1]


module.exports = {marshall, unmarshall}
