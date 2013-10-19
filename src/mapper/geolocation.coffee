check = require 'check-types'

geolocationModel = require 'src/model/Geolocation'


marshall = (geolocation) ->

  throw new Error 'Invalid geolocation' unless geolocation instanceof geolocationModel

  return {
      type: 'Point'
      coordinates: [geolocation.long, geolocation.lat]
    }


unmarshall = (data) ->

  throw new Error 'Invalid data' unless check.isObject data

  return new geolocationModel data.lat, data.long


module.exports = {marshall, unmarshall}
