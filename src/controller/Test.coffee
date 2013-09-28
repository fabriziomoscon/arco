MongoGateway = require 'src/lib/mongo/Gateway'

http = require 'src/middleware/httpResponse'

userRepository = new (require 'src/repository/User')

UserMapper = require 'src/mapper/User'

password = require 'src/lib/password'



index = (req, res, next) ->
  return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV is 'testing'
  res.end '''USAGE:
    curl -XPOST http://localhost:4000/testing/drop
    curl -XPOST http://localhost:4000/testing/fixtures
    curl -XPOST http://localhost:4000/testing/fixtures/users
  '''


dropDatabase = (req, res, next) ->

  return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV is 'testing'

  dropDatabase req, res, (err) ->
    return next( http.serverError err ) if err?
    return next()
  return


loadFixtures = (req, res, next) ->

  loadFixturesUsers req, res, next


loadFixturesUsers = (req, res, next) ->

  return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV in ['testing', 'staging']

  dropDatabase req, res, (err) ->
    return next( http.serverError err ) if err?

    loadUsers req, res, (err, users) ->
      return next( http.serverError err ) if err?

      log.debug 'USERS loaded', users.map (user) -> user.email

      return next()
    return
  return


module.exports = {loadFixturesUsers, loadFixtures, dropDatabase, index}



loadUsers = (req, res, callback) ->
  users = []
  for key, userData of require('test/data/db/user').getData()
    userData.password = password.hashSync userData.password if userData.password?
    try users.push UserMapper.unmarshall userData
    catch err then return callback err, null

  return userRepository.insert users, callback


dropDatabase = (req, res, callback) ->

  log.debug 'DROPPING DB'

  MongoGateway.db.dropDatabase (err) ->
    return callback( http.serverError err ) if err?
    return callback null, null
