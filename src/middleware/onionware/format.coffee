module.exports = (req, res, peel) ->

  res.format = 'text/html'

  if req.headers?.accept?

    if req.headers.accept.match 'application/json' then res.format = 'application/json'

  if req.query?.format?

    if req.query.format is 'json' then res.format = 'application/json'

  peel()