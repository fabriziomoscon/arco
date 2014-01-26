check = require 'check-types'

http = require 'src/middleware/httpResponse'

accountService = new (require 'src/service/Account')

apiUserMapper = require 'src/mapper/api/user'


# ----------

list = (req, res, next) ->

  if req.query?.limit?
    req.query.limit = parseInt req.query.limit, 10
    req.query.limit = undefined if req.query.limit <= 0
    req.query.offset = undefined unless req.query.offset?
    req.query.offset = parseInt req.query.offset, 10
    req.query.offset = undefined if req.query.offset < 0
  else
    req.query.offset = undefined

  accountService.findAllUsers req.query.offset, req.query.limit, (err, users) ->
    return next( http.serverError(err, 1041) ) if err?

    res.data = users

    return next()
  return

# ----------

read = (req, res, next) ->

  accountService.findUserById req.params.id, (err, user) ->
    return next( http.error(err, 1003) ) if err?
    return next( http.notFound('user not found', 1002) ) unless user?

    try res.data = apiUserMapper.marshall user
    catch err then return next( http.serverError(err, 1012) )

    return next()
  return

# ----------

create = (req, res, next) ->

  return next( http.badRequest('Invalid user data', 1010) ) if check.isEmptyObject req.body

  try user = apiUserMapper.unmarshallForCreating req.body
  catch err then return next( http.badRequest(err, 1011) )

  accountService.createUser user, (err, user) ->
    return next( http.error(err, 1013) ) if err?

    try res.data = apiUserMapper.marshall user
    catch err then return next( http.serverError(err, 1012) )

    res.status 201

    return next()
  return


# ----------

edit = (req, res, next) ->

  if check.isEmptyObject req.body
    return next( http.badRequest('Invalid body', 1021) )

  if req.body.password?
    return next( http.badRequest('Missing password confirmation', 1026) ) unless req.body.confirm_password?
    return next( http.badRequest('Password mismatch', 1027) ) unless req.body.confirm_password is req.body.password

  accountService.findUserById req.params.id, (err, user) ->
    return next( http.error(err, 1003) ) if err?
    return next( http.notFound('user not found', 1022) ) unless user?

    try user = apiUserMapper.unmarshallForEditing req.body, user
    catch err then return next( http.badRequest(err, 1023) )

    accountService.updateUserById req.params.id, user, (err, user) ->
      return next( http.error(err, 1025) ) if err?

      try res.data = apiUserMapper.marshall user
      catch err then return next( http.serverError(err, 1024) )

      return next()
    return
  return

# ----------

remove = (req, res, next) ->

  accountService.removeUserById req.params.id, (err, user) ->
    return next( http.error(err, 1032) ) if err?
    return next( http.notFound('user not found', 1031) ) unless user?

    res.status 204

    return next()
  return


module.exports = {create, read, edit, remove, list}
