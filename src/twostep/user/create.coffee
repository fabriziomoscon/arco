UserMapper       = require 'src/mapper/api/User'


module.exports = (req, res, peel) ->

  if res.data.body?.user?
    try res.data.body.user = UserMapper.marshall res.data.body.user
    catch err then console.log err

  peel()
