http = require 'src/controller/helper/httpResponse'

isValidObjectId = require 'src/validator/type/ObjectId'

AccountService = require 'src/service/Account'

UserMapper = require 'src/mapper/api/User'

check = require 'check-types'


class Controller

# ----------

  @index: (req, res, next) ->

    (new AccountService).findAllUsers (err, users) ->
      return next( http.serverError(err) ) if err?

      res.status 200
      res.data.body.users = users

      return next()
    return

# ----------

  @read: (req, res, next) ->

    unless isValidObjectId req.params.id
      return next( http.badRequest('Invalid user id') )

    (new AccountService).findUserById req.params.id, (err, user) ->
      return next( http.serverError(err) ) if err?
      return next( http.notFound('user not found') ) unless user?

      res.status 200
      res.data.body.user = user

      return next()
    return

# ----------

  @create: (req, res, next) ->

    return next( http.badRequest('Invalid user data') ) unless req.body?

    try user = UserMapper.unmarshall req.body
    catch err then return next( http.badRequest(err) )

    (new AccountService).createUser user, (err, user) ->
      return next( http.serverError(err) ) if err?

      res.status 201

      try res.data.body.user = UserMapper.marshall user
      catch err then return next(err)

      return next()
    return


# ----------

  @edit: (req, res, next) ->

    unless isValidObjectId req.params.id
      return next( http.badRequest('Invalid user id') )

    if check.isEmptyObject req.body
      return next( http.badRequest('Invalid body') )

    as = new AccountService
    as.findUserById req.params.id, (err, user) ->
      return next( http.serverError(err) ) if err?
      return next( http.notFound('user not found') ) unless user?
      
      try user = UserMapper.unmarshall req.body, user
      catch err then return next( http.badRequest(err) )

      as.updateUserById req.params.id, user, (err, user) ->
        return next( http.serverError(err) ) if err?

        res.status 200
        res.data.body.user = user

        return next()
      return
    return

# ----------

  @remove: (req, res, next) ->

    unless isValidObjectId req.params.id
      return next( http.badRequest('Invalid user id') )

    (new AccountService).removeUSerById req.params.id, (err, user) ->
      return next( http.serverError(err) ) if err?
      return next( http.notFound('user not found') ) unless user?

      res.status 200

      return next()
    return


module.exports = Controller
