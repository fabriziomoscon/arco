require('rootpath')()

walk = require 'walk'
fs = require 'fs'

# Get list of files recursively
walker = walk.walk './test', followLinks: false

walker.on 'file', (root, stat, next) ->

  file = fs.readFileSync("#{root}/#{stat.name}").toString 'utf8'
  lines = file.split '\n'
  lines.map (line) ->
    if line.match /not\.throw *$/
      throw new Error 'BAD BAD BAD: You must add parentheses when using should.not.throw!'

  next()
