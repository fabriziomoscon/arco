module.exports = (req, res, peel) ->

  if res.format is 'text/html'

    res.view = 'pages/index/index'

  peel()