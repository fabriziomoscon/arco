Hash     = require 'node-hash'
NodeSet  = require 'node-set'
ObjectID = require('mongodb').ObjectID

Place = require 'src/model/Place'
User  = require 'src/model/User'


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
    'Indoor 18m': {}
    'Indoor 25m': {}


  constructor: () ->
    @score_ids = new NodeSet ObjectID
    @times = new Hash Date
    @places = new Hash Place
    @participants = new NodeSet User


  setId: (id) ->
    throw new TypeError 'Invalid id' unless isValidObjectId id
    @id = id


  setType: (type) ->
    throw new TypeError 'Invalid type' unless type in Object.keys(Match.TYPES)
    @type = type


module.exports = Match
