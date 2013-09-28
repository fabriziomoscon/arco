hyperquest = require 'hyperquest'
url        = require 'url'

module.exports = (settings, userData, callback) ->

  console.log 'TRYING TO LOGIN', userData.email

  uri = url.format {
    protocol: settings.defaults.protocol
    hostname: settings.defaults.host
    port: settings.defaults.port
    pathname: "/auth/login"
  }

  options = 
    method: 'POST'
    headers:
      'Accept': 'application/json'
      'Content-Type': 'application/json'

  body = {
    email: userData.email
    password:userData.password
  }

  req = hyperquest.post uri, options
  req.write JSON.stringify body
  req.end()

  req.on 'error', (err) ->
    console.log "\x1B[0;31mERROR logging in: #{userData.email}\x1B[0m %s", err
    return callback err

  req.on 'response', (res) ->

    res.on 'error', (err) ->
      console.log "\x1B[0;31mERROR logging in: #{userData.email}\x1B[0m %s", err
      return callback err

    data = ''
    res.on 'data', (chunk) -> data += chunk
    res.on 'end', () -> 

      if res.statusCode isnt 200
        console.log data
        try data = JSON.parse data
        catch error
          console.log 'EXPECTED JSON, received'
          console.log data
          return callback error, null, null

        return callback new Error("#{data.error} for #{userData.email} with #{userData.password}"), null, null

      unless res.headers['set-cookie']?[0]?
        return callback new Error('Server failed to return a Set-Cookie header'), null, null

      sessionId = res.headers['set-cookie'][0].split(';')[0] || null
      console.log '\x1B[0;32mLOGGING IN:\x1B[0m %s', userData.email
      return callback null, userData.email, sessionId
