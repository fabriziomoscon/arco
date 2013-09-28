async = require 'async'
fs    = require 'fs'

require('rootpath')()

cookiesFileName = 'test/functional/cookies.json'
settings = new (require('ciao').Settings)()
settings.loadFromFile 'test/functional/config.json'

users = require('test/data/db/user').getData()

login = require './login'


afterConnection = (error, email, sessionId) ->
  throw error if error?
  if sessionId? then results.push {email:email, sessionId:sessionId}
  else throw new Error "Could not create session token for #{email}"


usersCredential = ({email: user.email, password: user.password} for key, user of users)

async.parallel(
  (usersCredential.map (userData) -> (afterConnection) -> login settings, userData, afterConnection),
  (err, results) ->
    if err?
      console.log '\x1B[0;31mERROR logging in some users:\x1B[0m %s', err
      return

    unless Array.isArray(results) and results.length > 0
      console.log '\x1B[0;31mERROR empty result:\x1B[0m %s', err
      return

    system_users = []
    system_users.push res[1] for res in results

    fs.writeFile cookiesFileName,
      JSON.stringify(
        {
          defaults: settings.defaults,
          config: {
            system_users: system_users
          }
        }, null, 2
      ),
      (err) ->
        console.log err if err?
        console.log 'CONFIG WRITTEN TO:', cookiesFileName
)
