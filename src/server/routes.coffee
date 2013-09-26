express = require 'express'
router  = new express.Router()

ensureAuthorized = require 'src/middleware/ensureAuthorized'

sessionIdReplaceRedirect = (action) ->
  return (req, res, next) ->
    if req.user?.id
      req.params.id = req.user.id
      return action req, res, next
    else
      res.status 401
      res.data.error = 'Unauthorized: Please sign in to continue'
      next()


controllers =
  user:     require 'src/controller/User'


# ---- User ----
router.get    '/user/me',  sessionIdReplaceRedirect controllers.user.read
router.get    '/users',                      controllers.user.index
router.post   '/user',                       controllers.user.create
router.get    '/user/:id',                   controllers.user.read
router.put    '/user/:id', ensureAuthorized, controllers.user.edit
router.delete '/user/:id', ensureAuthorized, controllers.user.remove

# -- Testing Only ---
if process.env.NODE_ENV in ['testing', 'staging']

  TestController = require 'src/controller/Test'

  router.post '/testing',                TestController.index
  router.post '/testing/drop',           TestController.dropDatabase
  router.post '/testing/fixtures',       TestController.loadFixtures
  router.post '/testing/fixtures/users', TestController.loadFixturesUsers

module.exports = router
