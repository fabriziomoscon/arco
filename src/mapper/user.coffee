objectIdMapper = require 'src/mapper/type/objectId'
hashMapper     = require 'src/mapper/type/hash'

UserModel = require 'src/model/User'

check = require 'check-types'


marshall = (user) ->

  throw new Error 'Invalid user' unless user instanceof UserModel

  data = {}

  data._id = objectIdMapper.marshall user.id if user.id?
  data.first_name = user.first_name if user.first_name?
  data.last_name = user.last_name if user.last_name?
  data.email = user.email if user.email?
  data.password = user.password if user.password?
  data.gender = user.gender if user.gender?
  data.birthdate = user.birthdate if user.birthdate?

  data.times = hashMapper.marshall user.times, 'times'

  return data


unmarshall = (data) ->

  throw new Error 'Invalid data' unless check.isObject data

  user = new UserModel first_name: data.first_name, last_name: data.last_name

  user.setId objectIdMapper.unmarshall data._id if data._id?
  user.setEmail data.email if data.email?
  user.setFirstName data.first_name if data.first_name?
  user.setLastName data.last_name if data.last_name?
  user.setPassword data.password if data.password?
  user.setBirthdate data.birthdate if data.birthdate?

  hashMapper.unmarshall data.times, user.times

  return user


module.exports = {marshall, unmarshall}
