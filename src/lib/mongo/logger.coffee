module.exports =

  error: (message, command) ->

    console.log('\x1B[0;31mMongo ERR:\x1B[0m %s', message) if message?
    console.log('\x1B[0;31mMongo ERR:\x1B[0m %s', command) if command?

  log: (message, command) ->

    console.log('\x1B[0;33mMongo LOG:\x1B[0m %s', message) if message?
    console.log('\x1B[0;33mMongo LOG:\x1B[0m %s', command) if command?

  debug: (message, command) ->

    if message?
      console.log '\x1B[0;36mMongo DEBUG:\x1B[0m %s', message

    if command?.json?
      console.log "collection [#{command.json.collectionName}]" if command.json.collectionName?
      console.log 'spec', command.json.spec if command.json.spec?
      console.log 'query', command.json.query if command.json.query?
      console.log 'document', command.json.document if command.json.document?

    # if command?.binary?
    #   console.log 'Mongo DEBUG bin', command.binary

  doDebug: true