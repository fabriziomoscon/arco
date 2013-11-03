Hash = require 'node-hash'

Place = require 'src/model/Place'
Score = require 'src/model/Score'
Match = require 'src/model/Match'

isValidObjectId = require 'src/validator/type/objectId'
isValidEmail    = require 'src/validator/email'


class User


  @MIN_PASSWORD_LENGTH: 8


  constructor: (props) ->
    throw new TypeError 'Invalid properties' unless props?
    throw new TypeError 'Invalid first name' unless props.first_name?
    throw new TypeError 'Invalid last name'  unless props.last_name?

    @setFirstName props.first_name
    @setLastName props.last_name
    @times = new Hash ['created'], Hash.comparator.Date
    @places = new Hash ['current', 'home'], (v) -> v instanceof Place
    @records = new Hash Object.keys(Match.TYPES), (v) -> v instanceof Score


  setId: (id) ->
    throw new TypeError 'Invalid id' unless isValidObjectId id
    @id = id
    return @


  setEmail: (email) =>
    throw new TypeError 'Invalid email' unless isValidEmail email
    @email = email
    return @


  setFirstName: (first_name) =>
    throw new TypeError 'Invalid first name' unless typeof first_name is 'string'
    @first_name = first_name
    return @


  setLastName: (last_name) =>
    throw new TypeError 'Invalid last name' unless typeof last_name is 'string'
    @last_name = last_name
    return @


  setPassword: (password) =>
    throw new TypeError 'Invalid password' unless typeof password is 'string'
    throw new Error 'Password too short' unless password.length >= User.MIN_PASSWORD_LENGTH
    @password = password
    return @


  setBirthdate: (birthdate) ->
    throw new TypeError 'Invalid birthdate' unless birthdate instanceof Date
    @birthdate = birthdate
    return @


  setGender: (gender) ->
    throw new TypeError 'Invalid gender' unless gender in ['M', 'F']
    @gender = gender
    return @


module.exports = User
