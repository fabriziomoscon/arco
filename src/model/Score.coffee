User  = require 'src/model/User'
Place = require 'src/model/Place'
Match = require 'src/model/Match'

isValidObjectId = require 'src/validator/type/objectId'

Hash = require 'node-hash'

check = require 'check-types'


class Score


  constructor: () ->
    @times = new Hash Date
    @places = new Hash Place
    @partials = new Hash Number
    @arrows = new Hash Object


  setId: (id) ->
    throw new TypeError 'Invalid id' unless isValidObjectId id
    @id = id


  setType: (type) ->
    throw new TypeError 'Invalid type' unless type in Object.keys(Match.TYPES)
    @type = type


  setTotal: (total) ->
    throw new TypeError 'Invalid total' unless check.isPositiveNumber total
    @total = total


  setUserId: (user_id) ->
    throw new TypeError 'Invalid user id' unless isValidObjectId user_id
    @user_id = user_id


  addPoint: (point, partial_name) ->
    throw new Error 'Score type not specified' unless @type?
    throw new TypeError 'Invalid point' unless check.isPositiveNumber(point) or point is 0
    throw new TypeError 'Invalid partial name' unless typeof partial_name is 'string' and partial_name.length > 0

    if Match.TYPES[@type].min_per_arrow? and point < Match.TYPES[@type].min_per_arrow
      throw new Error "Point #{point} is below the minimum for #{@type}"

    if Match.TYPES[@type].max_per_arrow? and point > Match.TYPES[@type].max_per_arrow
      throw new Error "Point #{point} is above the minimum for #{@type}"

    unless partial_name in Match.TYPES[@type].partials
      throw new Error "#{partial_name} is not valid for a #{@type} score"

    if not @arrows.get(partial_name)?
      @arrows.set partial_name, [point]
    else
      if @arrows.get(partial_name).length is Match.TYPES[@type].max_arrows
        throw new Error "this score has already #{Match.TYPES[@type].max_arrows}"
      @arrows.get(partial_name).push point

    return @arrows


module.exports = Score
