ObjectIdMapper = require 'src/mapper/type/ObjectId'

UserModel = require 'src/model/User'

check = require 'check-types'


marshall = (user) ->
  throw new Error 'Invalid user' unless user instanceof UserModel

  data = {}
  data._id = ObjectIdMapper.marshall user.id if user.id?
  data.first_name = user.first_name if user.first_name?
  data.last_name = user.last_name if user.last_name?
  data.email = user.email if user.email?
  data.password = user.password if user.password?
  data.gender = user.gender if user.gender?
  data.birthdate = user.birthdate if user.birthdate?
  
  data.times = {}
  for key, date of user.times.getData()
    data.times[key] = date

  return data


unmarshall = (data, user) ->
  throw new Error 'Invalid Data' unless check.isObject data
  throw new Error 'Invalid user' if user? and user not instanceof UserModel

  model = user || new UserModel first_name: data.first_name, last_name: data.last_name

  model.setId ObjectIdMapper.unmarshall data._id if data._id?
  model.setEmail data.email if data.email?
  model.setFirstName(data.first_name) if data.first_name?
  model.setLastName(data.last_name) if data.last_name?
  model.setPassword(data.password) if data.password?

  if data.times? and check.isObject(data.times)
    for key, date of data.times
      model.times.set key, date

  return model


module.exports = {marshall, unmarshall}
