validator = require 'validator'

Hash = require 'node-hash'

Place = require 'src/model/Place'

isValidObjectId = require 'src/validator/type/ObjectId'
isValidEmail    = require 'src/validator/email'


class User


  @MIN_PASSWORD_LENGTH: 8


  constructor: (props) ->
    throw new TypeError 'Invalid properties' unless props?
    throw new TypeError 'Invalid first name' unless props.first_name?
    throw new TypeError 'Invalid last name' unless props.last_name?

    @setFirstName props.first_name
    @setLastName props.last_name
    @times = new Hash Date
    @places = new Hash Place
    @records = new Hash Score


  setId: (id) ->
    throw new TypeError 'Invalid id' unless isValidObjectId id
    @id = id


  setEmail: (email) =>
    throw new TypeError 'Invalid email' unless isValidEmail email
    @email = email


  setFirstName: (first_name) =>
    throw new TypeError 'Invalid first name' unless typeof first_name is 'string'
    @first_name = first_name


  setLastName: (last_name) =>
    throw new TypeError 'Invalid last name' unless typeof last_name is 'string'
    @last_name = last_name


  setPassword: (password) =>
    throw new TypeError 'Invalid password' unless typeof password is 'string'
    validator.check(password, 'Invalid password').len(User.MIN_PASSWORD_LENGTH)
    @password = password


  setBirthdate: (dob) ->
    throw new TypeError 'Invalid birthdate' unless dob instanceof Date
    @dob = dob


  setSex: (sex) ->
    throw new TypeError 'Invalid sex' unless sex in ['M', 'F']
    @sex = sex


module.exports = User
