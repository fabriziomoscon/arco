Hash = require 'node-hash'

check = require 'check-types'


marshall = (hash, dataKey, marshall = (v) -> v) ->
  throw new TypeError 'Invalid Hash' unless hash instanceof Hash
  throw new TypeError 'Invalid dataKey' unless typeof dataKey is 'string'

  data = {}
  data[dataKey] = {}
  for k, v of hash.getData()
    data[dataKey][k] = marshall v

  return data[dataKey]


unmarshall = (dataHash, hash, unmarshall = (v) -> v) ->
  throw new TypeError 'Invalid Hash' unless hash instanceof Hash

  if dataHash? and check.isObject dataHash
    for k, v of dataHash
      hash.set k, unmarshall v


module.exports = {marshall, unmarshall}
