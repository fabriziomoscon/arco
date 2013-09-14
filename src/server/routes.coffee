express = require 'express'
router  = new express.Router()

sessionIdReplaceRedirect = (action) ->
  return (req, res, next) ->
    if req.user?.id
      req.params.id = req.user.id
      return action req, res, next
    else
      res.status 401
      res.data.body.error = 'Unauthorized: Please sign in to continue'
      res.onion.peel()


controllers =
  index:    require 'src/controller/Index'
  user:     require 'src/controller/User'


# ---- Home ----
router.get '/', controllers.index.index

# ---- User ----
router.get    '/user/me',  sessionIdReplaceRedirect controllers.user.read
router.get    '/users',    controllers.user.index
router.post   '/user',     controllers.user.create
router.get    '/user/:id', controllers.user.read
router.put    '/user/:id', controllers.user.edit
router.delete '/user/:id', controllers.user.remove

# -- Testing Only ---
if process.env.NODE_ENV in ['testing', 'staging']

  TestController = require 'src/controller/Test'

  router.post '/testing',                TestController.index
  router.post '/testing/drop',           TestController.dropDatabase
  router.post '/testing/fixtures',       TestController.loadFixtures
  router.post '/testing/fixtures/users', TestController.loadFixturesUsers

module.exports = router
