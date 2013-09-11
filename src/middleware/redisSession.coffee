express    = require 'express'
RedisStore = require('connect-redis')(express)


module.exports = (config) ->

  expireTime = 60*60*24*7*2
  express.session {
    store: new RedisStore {
      client: redisClient
      pass: config.redis.password
      db: 'sessions'
      ttl: expireTime
      prefix: 'sess:'
    }
    key: 'sid'
    secret: config.server.session.secret
    cookie: {
      maxAge: expireTime*1000
    }
  }
