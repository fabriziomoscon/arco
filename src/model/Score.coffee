User  = require 'src/model/User'
Place = require 'src/model/Place'

check = require 'check-types'

class Score


  constructor: () ->


  setRoundType: (type) ->


  setDate: (date) ->
    throw new Error 'Invalid date' unless date instanceof Date
    @date = date


  setLocation: (location) ->
    throw new Error 'Invalid place' unless place instanceof Place
    @location = place


  setTotal: (total) ->
    throw new Error 'Invalid total' unless check.isPositiveNumber total 
    @total = total


  setArcher: (user) ->
    throw new Error 'Invalid user' unless user instanceof User
    @archer = user




module.exports = Score