module.exports = (req, res, peel) ->

  res.onion.use (req, res, peel) ->

    if res.format is 'application/json' or ( req.query?.debug? and ( !process.env.NODE_ENV or process.env.NODE_ENV is 'development' ) )

      res.setHeader 'Content-Type', 'application/json'
      res.json res.data

    else peel()

  peel()