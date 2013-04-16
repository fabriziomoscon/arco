module.exports = (req, res, peel) ->

  res.status 405
  res.data.body.error = 'Method not allowed'
  res.view = 'pages/error/error'

  console.log 'ONION', res.data.body.error
  
  peel()