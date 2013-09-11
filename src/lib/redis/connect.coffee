Redis = require 'redis'

module.exports = (config, log, callback)->

  global.redisClient = redisClient = Redis.createClient config.redis.port, config.redis.host
  redisClient.on 'error', (err) -> log.error {err:err}
  redisClient.on 'connect', -> log.info "Connected: #{config.redis.host}:#{config.redis.port}"
  redisClient.on 'ready', -> log.info "connection ready"
  redisClient.on 'end', -> log.info "connection ended"
  redisClient.on 'drain', -> log.debug "connection draining"
  #redisClient.on 'idle', -> log.debug "connection idle"

  if config.redis.password? and config.redis.password.length > 0
    redisClient.auth config.redis.password, (err) ->
      if err?
        log.error {err:err}, 'AUTH ERROR'
        return callback err
      
      log.info "authenticated"
      return callback null

  callback()
