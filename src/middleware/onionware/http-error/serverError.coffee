module.exports = (error) ->

  return (req, res, peel) ->

    res.status 500
    res.data.body.error = 'Server error: ' + (error.message || error)
    res.view = 'pages/error/error'
    
    console.log 'ONION', res.data.body.error
    
    peel()