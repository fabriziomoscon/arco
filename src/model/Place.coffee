Geolocation = require 'src/model/Geolocation'

class Place

  
  constructor: () ->


  setGeolocation: (geolocation) ->
    throw new TypeError 'Invalid geolocation' unless geolocation instanceof Geolocation
    @geolocation = geolocation


  setCountry: (country) ->
    throw new TypeError 'Invalid country' unless typeof country is 'string'
    @country = country


  setCity: (city) ->
    throw new TypeError 'Invalid city' unless typeof city is 'string'
    @city = city


module.export = Place
