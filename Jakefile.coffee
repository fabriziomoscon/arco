'use strict';

fs = require 'fs'
{exec} = require 'child_process'
watcher = require 'watch'
hogan = require 'hogan.js'

commands =
  prepare: 'npm install'
  lint: './node_modules/.bin/coffeelint -f coffeelint.json '
  test: './node_modules/.bin/mocha -u tdd -R spec --globals window,navigator,$,google,document --colors client/test'
  cscompile: './node_modules/.bin/coffee -c -o ./client/lib ./client/src'
  sitebundle: './node_modules/.bin/browserify -o ./client/lib/site.js ./client/lib/bootstrap.js'
  # TODO: Re-enable minification when code is more stable (turned off to aid debugging).
  siteminify: './node_modules/.bin/uglifyjs --output ./public/lib/site.min.js ./client/lib/site.js'

# TODO: Better optimising only what's necessary here would reduce our JS footprint.
templateTypes =
  site: [ 'pages', 'components' ]

viewDirectory = 'view/'
viewExtension = '.html'

desc 'Install dependencies.'
task 'prepare', ->
  runTask prepare, 'Preparing the build environment...'
, async: true

desc 'Lint the front-end source code.'
task 'lint', ->
  runTask lint, 'Linting CoffeeScript...'
, async: true

desc 'Run the front-end unit tests against the source code.'
task 'cstest', ->
  process.env.NODE_PATH = './client/src'
  runTask test, 'Testing CoffeeScript...'
, async: true

desc 'Compile the front-end source code into JavaScript.'
task 'cscompile', ->
  runTask cscompile, 'Compiling CoffeeScript...'
, async: true

desc 'Run the front-end unit tests against the compiled JavaScript.'
task 'jstest', [ 'cscompile' ], ->

  process.env.NODE_PATH = './client/lib'
  runTask test, 'Testing JavaScript...'
, async: true

desc 'Compile the view templates into JavaScript strings.'
task 'tpcompile', ->
  runTask tpcompile, 'Compiling templates...'
, async: false

desc 'Bundle the compiled JavaScript as an atomic package for the website.'
task 'sitebundle', [ 'cscompile', 'tpcompile' ], ->
  runTask sitebundle, 'Bundling site JavaScript...'
, async: true

desc 'Bundle the compiled JavaScript as atomic packages.'
task 'bundle', [ 'sitebundle' ]

desc 'Minify the bundled site JavaScript.'
task 'siteminify', [ 'sitebundle' ], ->
  runTask siteminify, 'Minifying site JavaScript...'
, async: true

desc 'Minify the bundled JavaScript.'
task 'minify', [ 'siteminify' ]

desc 'Watch the front-end source code for changes then re-bundle as necessary.'
task 'watch', [ 'prepare' ], ->
  runTask watch, 'Watching CoffeeScript...'
, async: true

runTask = (operation, message) ->
  console.log message
  operation()

prepare = ->
  runCommand commands.prepare

lint = ->
  files = getFiles 'client/**/*.coffee'
  runCommands files.map (file) ->
    commands.lint + file

test = ->
  runCommand commands.test

cscompile = ->
  runCommand commands.cscompile

tpcompile = ->
  for own context, types of templateTypes
    writeTemplates context, compileTemplates(types)

compileTemplates = (types) ->
  templates = {}

  for type in types
    files = getFiles viewDirectory + type + '/**/*' + viewExtension

    for file in files
      template = fs.readFileSync(__dirname + '/' + file, 'utf-8')
      templates[getTemplateName file] =
        text: template
        compiled: hogan.compile(template, asString: true)

  templates

getTemplateName = (path) ->
  path.substring viewDirectory.length, path.length - viewExtension.length

writeTemplates = (context, templates) ->
  fs.writeFileSync __dirname + '/client/lib/templates-' + context + '.js', '"use strict";\nmodule.exports = ' + JSON.stringify(templates) + ';', 'utf8'

sitebundle = ->
  runCommand commands.sitebundle

siteminify = ->
  runCommand commands.siteminify

watch = ->
  watcher.watchTree './client/src', (file, current, previous) ->
    if current? or previous?
      console.log 'Change detected!'
      jake.Task.bundle.reenable()
      jake.Task.bundle.invoke()

runCommand = (command) ->
  exec command, { cwd: __dirname }, (error, stdout, stderr) ->
    console.log stdout
    handleError error
    after()

runCommands = (commands) ->
  exec commands.shift(), { cwd: __dirname }, (error, stdout, stderr) ->
    console.log stdout
    handleError error
    if commands.length > 0
      runCommands commands
    else
      after()

handleError = (error) ->
  if error?
    console.log error.message
    process.exit 1

after = ->
  process.env.NODE_PATH = originalNodePath
  complete()

getFiles = (glob) ->
  list = new jake.FileList()
  list.include glob
  list.toArray()

originalNodePath = process.env.NODE_PATH