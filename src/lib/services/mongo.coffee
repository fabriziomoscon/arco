MongoGateway = require 'src/lib/mongo/Gateway'
mongoLogger  = require 'src/lib/mongo/logger'


module.exports = (config, log, callback) ->

  db = server = replSet = mongos = { logger: mongoLogger(log) }

  global.mongoGateway = mongoGateway = new MongoGateway
  mongoGateway.connect config.db.mongo.url, {db, server, replSet, mongos}, callback
