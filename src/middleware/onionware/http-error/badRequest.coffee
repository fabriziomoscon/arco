module.exports = (error) ->

  return (req, res, peel) ->

    res.status 400
    res.data.body.error = 'Bad request: ' + (error.message || error)

    console.log 'ONION', res.data.body.error

    peel()