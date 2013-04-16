module.exports = (error) ->

  return (req, res, peel) ->

    res.status 404
    res.data.body.error = 'Not found: ' + (error.message || error)
    res.view = 'pages/error/notFound'

    console.log 'ONION', res.data.body.error
    
    peel()