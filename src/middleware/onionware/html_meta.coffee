_ = require 'underscore'

getConfig = require 'src/server/config'

module.exports = (request, response, peel) ->

  if response.format is 'text/html'

    response.data.meta.title = getConfig(process.env.NODE_ENV).client.seo.title

  peel()