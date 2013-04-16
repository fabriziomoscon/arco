process.env.NODE_ENV ?= 'development'

express  = require 'express'
path     = require 'path'

app = express()
applicationPath = path.resolve __dirname
app.set 'baseDir', applicationPath

app.configure require 'src/server/init'
app.configure require 'src/server/routes'

# Far better error stack debugging. Do not use in production!
if process.env.NODE_ENV is 'development'

  # Breakdown
  breakdown = require 'breakdown'
  app.use (err, req, res, next) ->
    breakdown err
    res.writeHead 500, 'Content-Type': 'text/plain'
    res.end err.stack

server = app.listen app.get('port'), '0.0.0.0'
console.log 'LISTENING ON PORT ' + app.get('port')