module.exports = (req, res, peel) ->

  res.status 401
  res.data.body.error = 'Unauthorized: Please sign in to continue'
  res.view = 'pages/auth/unauthorized'

  console.log 'ONION', res.data.body.error

  peel()