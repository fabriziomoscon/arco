Hash     = require 'node-hash'
NodeSet  = require 'node-set'
ObjectID = require('mongodb').ObjectID

Place = require 'src/model/Place'
User  = require 'src/model/User'

isValidObjectId = require 'src/validator/type/objectId'


class Match


  @TYPES = 
    'FITA 90+70+50+30':
      max_arrows: 144
      max_per_arrow: 10
      min_per_arrow: 0
      partials: ['90', '70', '50', '30']
      num_of_end:
        90: 6
        70: 6
        50: 12
        30: 12
      arrows_per_end:
        90: 6
        70: 6
        50: 3
        30: 3

    'FITA 70+60+50+30': {}
    'FITA 50+40+30+20': {}
    '70m qualification': {}
    'H+F 12+12': {}
    'H+F 24+24': {}
    'Indoor 18m': {
      max_arrows: 60
      min_per_arrow: 0
      max_per_arrow: 10
      partials: ['first', 'second']
    }
    'Indoor 25m': {
      max_arrows: 60
      min_per_arrow: 0
      max_per_arrow: 10
      partials: ['first', 'second']
    }
    'Indoor 25+18': {
      max_arrows: 120
      min_per_arrow: 0
      max_per_arrow: 10
      partials: ['first 25m', 'second 25m', 'first 18m', 'second 18m']
    }


  constructor: () ->
    @score_ids = new NodeSet ObjectID
    @times = new Hash ['created'], Hash.comparator.Date
    @places = new Hash ['address'], (v) -> v instanceof Place
    @participants = new NodeSet User


Object.defineProperty Match.prototype, 'id', {
  get: () -> this._id
  set: (value) ->
    throw new TypeError 'Invalid id' unless isValidObjectId value
    this._id = value
}

Object.defineProperty Match.prototype, 'type', {
  get: () -> this._type
  set: (value) ->
    throw new TypeError 'Invalid type' unless isValidObjectId value
    throw new TypeError 'Invalid type' unless value in Object.keys(Match.TYPES)
    this._type = value
}


module.exports = Match
