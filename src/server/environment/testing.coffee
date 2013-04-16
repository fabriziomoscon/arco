module.exports = ->

  console.log 'Loading config: TESTING'
  
  @set 'MongoLogger', require 'src/lib/mongo/logger'