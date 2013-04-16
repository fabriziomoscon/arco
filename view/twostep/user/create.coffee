UserMapper       = require 'src/mapper/api/User'
ClientUserMapper = require 'client/src/mapper/User'

module.exports = (req, res, peel) ->

  if res.data.body?.user?
    try res.data.body.user = UserMapper.marshall res.data.body.user
    catch err then console.log err

  if res.format is 'text/html'

    res.view = 'pages/user/create'
    
    if res.data.body?.user?
      try res.data.body.user = ClientUserMapper.marshall res.data.body.user
      catch err then console.log err

  peel()