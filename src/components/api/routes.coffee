express = require 'express'
router  = new express.Router()

ensureAuthorized   = require 'src/middleware/ensureAuthorized'
sessionRestriction = require 'src/middleware/sessionRestriction'


module.exports = (config, controllers, passport) ->

  # ---- Auth ----
  router.post   '/auth/login',                 controllers.auth.login

  # ---- User ----
  router.get    '/user/me',  ensureAuthorized, sessionRestriction, controllers.user.read
  router.put    '/user/me',  ensureAuthorized, sessionRestriction, controllers.user.edit
  router.delete '/user/me',  ensureAuthorized, sessionRestriction, controllers.user.remove
  router.get    '/user/:id([0-9A-F]{24})',     controllers.user.read
  router.post   '/user',                       controllers.user.create
  router.get    '/users',                      controllers.user.list

  #------ Score -----
  router.post   '/score',                      ensureAuthorized, controllers.score.create
  router.put    '/score/:id([0-9A-F]{24})',    ensureAuthorized, controllers.score.edit


  # -- Testing Only ---
  if process.env.NODE_ENV in ['testing', 'staging']

    router.post '/testing',                controllers.test.index
    router.post '/testing/drop',           controllers.test.dropDatabase
    router.post '/testing/fixtures',       controllers.test.loadFixtures
    router.post '/testing/fixtures/users', controllers.test.loadFixturesUsers

