express = require 'express'
router  = new express.Router()

ensureAuthorized   = require 'src/middleware/ensureAuthorized'
sessionRestriction = require 'src/middleware/sessionRestriction'


controllers =
  auth:     require 'src/controller/Auth'
  user:     require 'src/controller/User'

# ---- Auth ----
router.post   '/auth/login',                 controllers.auth.login

# ---- User ----
router.get    '/user/me',  ensureAuthorized, sessionRestriction controllers.user.read
router.put    '/user/me',  ensureAuthorized, sessionRestriction controllers.user.edit
router.delete '/user/me',  ensureAuthorized, sessionRestriction controllers.user.remove
router.get    '/user/:id',                   controllers.user.read
router.post   '/user',                       controllers.user.create
router.get    '/users',                      controllers.user.index

# -- Testing Only ---
if process.env.NODE_ENV in ['testing', 'staging']

  TestController = require 'src/controller/Test'

  router.post '/testing',                TestController.index
  router.post '/testing/drop',           TestController.dropDatabase
  router.post '/testing/fixtures',       TestController.loadFixtures
  router.post '/testing/fixtures/users', TestController.loadFixturesUsers


module.exports = router
