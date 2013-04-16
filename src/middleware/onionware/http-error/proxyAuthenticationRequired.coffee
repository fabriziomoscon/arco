module.exports = (error) ->

  return (req, res, peel) ->

    res.status 407
    res.data.body.error = 'Proxy Authentication required: ' + (error.message || error)
    res.view = 'pages/error/error'

    console.log 'ONION', res.data.body.error
    
    peel()