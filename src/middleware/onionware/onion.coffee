exports = module.exports = (req, res, next) ->

  res.data = meta: {}, body: {}
  res.onion = layers: []
  
  res.onion.use = (layer) ->
    res.onion.layers.push layer
    return res.onion

  res.onion.next = () ->
    layer = res.onion.layers.shift()
    if typeof layer is 'function' then layer( req, res, res.onion.next )

  res.onion.peel = res.onion.next

  next()