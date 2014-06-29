module.exports = (log) ->

  return {

    error: (message, command) ->
      log.error {command}, message

    log: (message, command) ->
      log.info {command}, message

    debug: (message, command) ->

      lobj = {}

      if command?.json?
        lobj.collection = command.json.collectionName if command.json.collectionName?
        lobj.spec = command.json.spec if command.json.spec?
        lobj.query = command.json.query if command.json.query?
        lobj.document = command.json.document if command.json.document?

      log.debug {command:lobj}, message
  }
