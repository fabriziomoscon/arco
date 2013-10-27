module.exports = (unmarshall, callback, single = true) ->

  return (err, data) ->

    return callback err, null if err?
    return callback null, null unless data?

    data = [data] unless Array.isArray data

    list = data.map( (record) ->
      try return unmarshall record
      catch err then log.error {err}, 'Impossible to unmarshall some record'
    ).filter (model) -> return model?

    list = list[0] if single

    return callback null, list
