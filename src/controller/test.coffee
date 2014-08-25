MongoGateway = global.mongoGateway

http = require 'src/middleware/httpResponse'

userRepository = new (require 'src/repository/User')

userMapper = require 'src/mapper/user'

password = require 'src/lib/password'


exports = module.exports = () ->

  return {


    index: (req, res, next) ->
      return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV is 'testing'
      res.end '''USAGE:
        curl -XPOST http://localhost:4000/testing/drop
        curl -XPOST http://localhost:4000/testing/fixtures
        curl -XPOST http://localhost:4000/testing/fixtures/users
      '''


    dropDatabase: (req, res, next) ->

      unless process.env.NODE_ENV is 'testing'
        return next( http.badRequest 'Invalid ENV' )

      _dropDatabase req, res, (err) ->
        if err?
          return next( http.serverError err )

        res.status 204

        return next()
      return


    loadFixtures: (req, res, next) ->

      exports().loadFixturesUsers req, res, next


    loadFixturesUsers: (req, res, next) ->

      unless process.env.NODE_ENV in ['testing', 'staging']
        return next( http.badRequest 'Invalid ENV' )

      _dropDatabase req, res, (err) ->
        if err?
          return next( http.serverError err )

        _loadUsers req, res, (err, users) ->
          if err?
            return next( http.serverError err )

          log.debug 'USERS loaded', users.map (user) -> user.email
          res.status 204

          return next()
        return
      return


  }



_loadUsers = (req, res, callback) ->
  users = []
  for key, userData of require('test/data/db/user').getData()
    userData.password = password.hashSync userData.password if userData.password?
    try users.push userMapper.unmarshall userData
    catch err then return callback err, null

  return userRepository.insert users, callback


_dropDatabase = (req, res, callback) ->

  log.debug 'DROPPING DB'

  MongoGateway.db.dropDatabase (err) ->
    return callback( http.serverError err ) if err?
    return callback null, null
