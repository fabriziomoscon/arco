module.exports = (error) ->

  return (req, res, peel) ->

    res.status 403
    res.data.body.error = 'Forbidden: ' + 
      (error.message || 'You are not authorized to perform this operation')
    res.view = 'pages/error/error'

    console.log 'ONION Forbidden', res.data.body.error

    peel()