module.exports = (req, res, peel) ->

  res.onion.use (req, res, peel) ->

    if res.format is 'text/html'

      if not res.view?
        console.trace 'View File not found'
        res.view = 'pages/error/error'

      res.setHeader 'Content-Type', 'text/html'
      res.render res.view, res.data

    else peel()

  peel()