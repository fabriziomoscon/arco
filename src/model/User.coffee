validator = require 'validator'

isValidObjectId = require 'src/validator/type/ObjectId'
isValidEmail    = require 'src/validator/email'

class User

  @minPasslength: 8

  constructor: (props) ->
    throw new Error 'Invalid first name' unless props?.first_name?
    throw new Error 'Invalid last name' unless props?.last_name?

    @setFirstName props.first_name
    @setLastName props.last_name


  setEmail: (email) =>
    throw new Error 'Invalid email' unless isValidEmail email
    @email = email


  setFirstName: (firstName) =>
    throw new Error 'Invalid first name' unless typeof firstName is 'string'
    @first_name = firstName


  setLastName: (lastName) =>
    throw new Error 'Invalid last name' unless typeof lastName is 'string'
    @last_name = lastName


  setPassword: (password) =>
    throw new Error 'Invalid password' unless typeof password is 'string'
    validator.check(password, 'Invalid password').len(User.minPasslength)
    @password = password


  setId: (id) ->
    throw new Error 'Invalid id' unless isValidObjectId id
    @id = id


  setCreatedAt: (createdAt) ->
    throw new Error 'Invalid created at' unless createdAt instanceof Date
    @createdAt = createdAt


  setBirthdate: (birthdate) ->
    throw new Error 'Invlaid birthdate' unless birthdate instanceof Date


module.exports = User