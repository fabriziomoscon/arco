User = require 'src/model/User'

class User

  @marshall: (user) ->

    throw new Error 'Invalid user' unless user instanceof User

    return user


  @unmarshall: (data) ->

    throw new Error 'Invalid user data' unless data?

    return data


module.exports = User