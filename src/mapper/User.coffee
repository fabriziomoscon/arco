ObjectIdMapper = require 'src/mapper/type/ObjectId'

UserModel = require 'src/model/User'

check = require 'check-types'

class User

  @marshall: (user) ->

    throw new Error 'Invalid user' unless user instanceof UserModel

    data = {}
    data._id = ObjectIdMapper.marshall user.id if user.id?
    data.first_name = user.first_name if user.first_name?
    data.last_name = user.last_name if user.last_name?
    data.email = user.email if user.email?
    data.password = user.password if user.password?
    data.gender = user.gender if user.gender?
    data.created_at = user.createdAt if user.createdAt?

    return data


  @unmarshall: (data, user) ->

    return null if data is null

    throw new Error 'Invalid Data' unless check.isObject data
    throw new Error 'Invalid user' if user? and user not instanceof UserModel

    model = user || new UserModel first_name: data.first_name, last_name: data.last_name
    
    model.id = ObjectIdMapper.unmarshall data._id if data._id?
    model.setEmail data.email if data.email?
    model.setFirstName(data.first_name) if data.first_name?
    model.setLastName(data.last_name) if data.last_name?
    model.setPassword(data.password) if data.password?
    model.setCreatedAt data.created_at if data.created_at?

    return model


module.exports = User