Hash  = require 'node-hash'
check = require 'check-types'

Place = require 'src/model/Place'
Score = require 'src/model/Score'
Match = require 'src/model/Match'

isValidObjectId = require 'src/validator/type/objectId'
isValidEmail    = require 'src/validator/email'


class User


  @MIN_PASSWORD_LENGTH: 8


  constructor: (props) ->
    throw new TypeError 'Invalid properties' unless check.isObject props

    @first_name = props.first_name
    @last_name = props.last_name
    @times = new Hash ['created'], Hash.comparator.Date
    @places = new Hash ['current', 'home'], (v) -> v instanceof Place
    @records = new Hash Object.keys(Match.TYPES), (v) -> v instanceof Score


Object.defineProperty User.prototype, 'id', {
  get: () -> this._id
  set: (value) ->
    throw new TypeError 'Invalid id' unless isValidObjectId value
    this._id = value
}

Object.defineProperty User.prototype, 'email', {
  get: () -> this._email
  set: (value) ->
    throw new TypeError 'Invalid email' unless isValidEmail value
    this._email = value
}

Object.defineProperty User.prototype, 'first_name', {
  get: () -> this._first_name
  set: (value) ->
    throw new TypeError 'Invalid first name' unless typeof value is 'string'
    this._first_name = value
}

Object.defineProperty User.prototype, 'last_name', {
  get: () -> this._last_name
  set: (value) ->
    throw new TypeError 'Invalid last name' unless typeof value is 'string'
    this._last_name = value
}

Object.defineProperty User.prototype, 'password', {
  get: () -> this._password
  set: (value) ->
    throw new TypeError 'Invalid password' unless typeof value is 'string'
    this._password = value
}

Object.defineProperty User.prototype, 'birthdate', {
  get: () -> this._birthdate
  set: (value) ->
    throw new TypeError 'Invalid birthdate' unless value instanceof Date
    this._birthdate = value
}

Object.defineProperty User.prototype, 'gender', {
  get: () -> this._gender
  set: (value) ->
    throw new TypeError 'Invalid gender' unless value in ['M', 'F']
    this._gender = value
}


module.exports = User
