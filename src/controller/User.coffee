http = require 'src/controller/helper/httpResponse'

isValidObjectId = require 'src/validator/type/ObjectId'

AccountService = require 'src/service/Account'

UserMapper = require 'src/mapper/api/User'

check = require 'check-types'

class Controller

# ----------

  @index: (req, res, next) ->

    (new AccountService).findAllUsers (err, users) ->
      return res.onion.use( http.serverError(error) ).peel() if err?

      res.status 200
      res.data.body.users = users
      return res.onion.peel()

# ----------

  @single: (req, res, next) ->

    unless isValidObjectId req.params.id
      return res.onion.use( http.badRequest(new Error 'Invalid user id') ).peel()

    (new AccountService).findUserById req.params.id, (err, user) ->
      return res.onion.use( http.serverError(err) ).peel() if err?
      return res.onion.use( http.notFound(new Error 'user not found') ).peel() unless user?

      res.status 200
      res.data.body.user = user
      return res.onion.peel()

# ----------

  @create: (req, res, next) ->

    return res.onion.use( http.badRequest(new Error 'Invalid user data') ).peel() unless req.body?

    if req.method is 'POST'

      try user = UserMapper.unmarshall req.body
      catch err then return res.onion.use( http.badRequest(err) ).peel()

      (new AccountService).createUser user, (err, user) ->
        return res.onion.use( http.serverError(err) ).peel() if err?

        res.status 201
        res.data.body.user = user
        return res.onion.peel()

    else return res.onion.peel()

# ----------

  @edit: (req, res, next) ->

    unless isValidObjectId req.params.id
      return res.onion.use( http.badRequest(new Error 'Invalid user id') ).peel()

    if check.isEmptyObject req.body
      return res.onion.use( http.badRequest(new Error 'Invalid body') ).peel()
    
    as = new AccountService
    as.findUserById req.params.id, (err, user) ->
      return res.onion.use( http.serverError(err) ).peel() if err?
      return res.onion.use( http.notFound(new Error 'user not found') ).peel() unless user?
      
      try user = UserMapper.unmarshall req.body, user
      catch err then return res.onion.use( http.badRequest(err) ).peel()

      as.updateUserById req.params.id, user, (err, user) ->
        return res.onion.use( http.serverError(err) ).peel() if err?

        res.status 200
        res.data.body.user = user
        return res.onion.peel()

# ----------

  @remove: (req, res, next) ->

    unless isValidObjectId req.params.id
      return res.onion.use( http.badRequest(new Error 'Invalid user id') ).peel()

    (new AccountService).removeUSerById req.params.id, (err, user) ->
      return res.onion.use( http.serverError(err) ).peel() if err?
      return res.onion.use( http.notFound(new Error 'user not found') ).peel() unless user?

      res.status 200
      return res.onion.peel()


module.exports = Controller