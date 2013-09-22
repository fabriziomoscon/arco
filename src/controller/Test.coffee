MongoGateway = require 'src/lib/mongo/Gateway'

http = require 'src/middleware/httpResponse'

accountService = new (require 'src/service/Account')

UserMapper = require 'src/mapper/User'


class Controller


  @index: (req, res) ->
    return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV is 'testing'
    res.end '''USAGE:
      curl -XPOST http://localhost:4000/testing/drop
      curl -XPOST http://localhost:4000/testing/fixtures
      curl -XPOST http://localhost:4000/testing/fixtures/users

    '''


  @dropDatabase: (req, res) ->

    alwaysResponsInJSON req, res

    return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV is 'testing'

    dropDatabase req, res


  @loadFixtures: (req, res) ->

    Controller.loadFixturesUsers req, res


  @loadFixturesUsers: (req, res) ->

    alwaysResponsInJSON req, res

    return next( http.badRequest 'Invalid ENV' ) unless process.env.NODE_ENV in ['testing', 'staging']

    dropDatabase req, res, (err) ->
      return next( http.serverError err ) if err?

      loadUsers req, res, (err) ->
        return next( http.serverError err ) if err?

        res.format = 'application/json'
        return next()


module.exports = Controller


# local functions

alwaysResponsInJSON = (req, res) ->
  next (req,res,peel) ->
    res.format = 'application/json'
    peel()


loadUsers = (req, res, callback) ->
  for key, userData of require('test/data/db/user').getData()
    accountService.createUser UserMapper.unmarshall(userData), (err, result) ->
      if err?
        console.log err if err?
        return callback err, null 

  # TODO this is not really completely async proof
  return callback null, null


dropDatabase = (req, res, next) ->
  MongoGateway.db.dropDatabase (err) ->
  return next( http.serverError err ) if err?

  return next null if next instanceof Function

  res.format = 'application/json'
  return next()
