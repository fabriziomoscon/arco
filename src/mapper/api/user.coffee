check = require 'check-types'

apiDateMapper = require 'src/mapper/api/type/date'

UserModel = require 'src/model/User'


marshall = (user) ->

  throw new TypeError 'Invalid user' unless user instanceof UserModel

  data = {}
  data.id = user.id if user.id?
  data.first_name = user.first_name if user.first_name?
  data.last_name = user.last_name if user.last_name?
  data.email = user.email if user.email?

  data.times = user.times.marshall apiDateMapper.marshall

  return data


unmarshallForCreating = (data) ->

  throw new TypeError 'Invalid user data' unless check.isObject data

  initData = {}
  initData.first_name = data.first_name if data.first_name?
  initData.last_name = data.last_name if data.last_name?

  user = new UserModel initData

  user.email = data.email if data.email?
  user.password = data.password if data.password?

  return user


unmarshallForEditing = (data, user) ->

  throw new TypeError 'Invalid user' unless user instanceof UserModel

  user.first_name = data.first_name if data.first_name?
  user.last_name = data.last_name if data.last_name?
  user.email = data.email if data.email?
  user.password = data.password if data.password?
  user.gender = data.gender if data.gender?

  return user


module.exports = {marshall, unmarshallForCreating, unmarshallForEditing}
