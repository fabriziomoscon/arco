Hash = require 'node-hash'
check = require 'check-types'

User  = require 'src/model/User'
Place = require 'src/model/Place'
Match = require 'src/model/Match'

isValidObjectId = require 'src/validator/type/objectId'


class Score


  constructor: (type, rules) ->
    @type = type

    unless rules?
      rules = Match.TYPES[type]

    @rules = rules
    @times = new Hash ['created'], Hash.comparator.Date
    @places = new Hash ['address'], (v) -> v instanceof Place
    @arrows = new Hash rules.partials, Hash.comparator.Array, []


  addPoint: (point, partial_name) ->
    throw new TypeError 'Invalid point' unless check.isPositiveNumber(point) or point is 0
    throw new TypeError 'Invalid partial name' unless typeof partial_name is 'string' and partial_name.length > 0

    if @rules.min_per_arrow? and point < @rules.min_per_arrow
      throw new Error "#{point} is below the minimum for #{@type}"

    if @rules.max_per_arrow? and point > @rules.max_per_arrow
      throw new Error "#{point} is above the maximum for #{@type}"

    unless partial_name in @rules.partials
      throw new Error "#{partial_name} is not a valid partial for #{@type} score"

    if @arrows[partial_name].length is @rules.max_arrows
      throw new Error "this score has already #{@rules.max_arrows} arrows"

    @arrows[partial_name].push point

    return @arrows


  _calculateTotal: () ->
    tot = 0
    for partialName in @arrows.keys()
      if @arrows[partialName]? and @arrows[partialName].length > 0
        tot += @arrows[partialName].reduce (a, b) -> a+b
    return tot


Object.defineProperty Score.prototype, 'rules', {
  get: () -> this._rules
  set: (value) ->
    throw new TypeError 'Invalid rules' unless check.isObject value
    throw new TypeError 'Invalid max arrows' unless check.isPositiveNumber(value.max_arrows) or value.max_arrows is 0
    throw new TypeError 'Invalid min per arrow' unless check.isPositiveNumber(value.min_per_arrow) or value.min_per_arrow is 0
    throw new TypeError 'Invalid max per arrow' unless check.isPositiveNumber(value.max_per_arrow)
    throw new TypeError 'Invalid partials' unless Array.isArray value.partials
    this._rules = value
}

Object.defineProperty Score.prototype, 'id', {
  get: () -> this._id
  set: (value) ->
    throw new TypeError 'Invalid id' unless isValidObjectId value
    this._id = value
}

Object.defineProperty Score.prototype, 'type', {
  get: () -> this._type
  set: (value) ->
    throw new TypeError 'Invalid type' unless value in Object.keys(Match.TYPES)
    this._type = value
}

Object.defineProperty Score.prototype, 'total', {
  get: () ->
    unless this._total?
      this._total = @_calculateTotal()
    return this._total
  set: (value) ->
    throw new TypeError 'Invalid total' unless check.isPositiveNumber(value) or value is 0
    this._total = value
}

Object.defineProperty Score.prototype, 'user_id', {
  get: () -> this._user_id
  set: (value) ->
    throw new TypeError 'Invalid user id' unless isValidObjectId value
    this._user_id = value
}


module.exports = Score
