controllers =
  index:    require 'src/controller/Index'
  user:     require 'src/controller/User'

# A helpful function to load twostep views and dispatch controllers
dispatch = (controllerName, actionName) ->
  return (req, res, next) ->
    action = controllers[controllerName]
    if actionName and typeof action[actionName] is 'function'
      action = action[actionName]
      try res.onion.use require "view/twostep/#{controllerName}/#{actionName}"
      catch e then console.error "twostep view not defined for #{controllerName}/#{actionName}", e
    action req, res, next

sessionIdReplaceRedirect = (action) ->
  return (req, res, next) ->
    if req.user?.id
      req.params.id = req.user.id
      return action req, res, next
    else
      res.status 401
      res.data.body.error = 'Unauthorized: Please sign in to continue'
      res.view = 'pages/auth/unauthorized'
      res.onion.peel()

# Routes
module.exports = ->

  # ---- Home ----
  @get '/',                 dispatch 'index', 'index'

  # ---- User ----
  @get  '/user/me',  sessionIdReplaceRedirect dispatch 'user', 'single'
  @get  '/user',     dispatch 'user', 'index'
  @post '/user',     dispatch 'user', 'create'
  @get  '/user/:id', dispatch 'user', 'read'
  @put  '/user/:id', dispatch 'user', 'edit'
  @del  '/user/:id', dispatch 'user', 'remove'

  # -- Testing Only ---
  if process.env.NODE_ENV in ['testing', 'staging']

    TestController = require 'src/controller/Test'
    @post '/testing',                TestController.index
    @post '/testing/drop',           TestController.dropDatabase
    @post '/testing/fixtures',       TestController.loadFixtures
    @post '/testing/fixtures/users', TestController.loadFixturesUsers