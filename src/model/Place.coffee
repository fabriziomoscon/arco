Geolocation = require 'src/model/Geolocation'

class Place

  
  constructor: () ->


  setGeolocation: (geolocation) ->
    throw new Error 'Invalid geolocation' unless geolocation instanceof Geolocation
    @geolocation = geolocation


  setCountry: (country) ->
    throw new Error 'Invalid country' unless typeof country is 'string'
    @country = country


  setCity: (city) ->
    throw new Error 'Invalid city' unless typeof city is 'string'
    @city = city


module.export = Place