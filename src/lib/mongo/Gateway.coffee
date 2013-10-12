Db       = require('mongodb').Db
Server   = require('mongodb').Server
ObjectID = require('mongodb').ObjectID


class MongoGateway

  @db = undefined

  @setLogger: (@logger) ->

  @getLogger: () ->
    return MongoGateway.logger

  # Options
  #   safe {true | {w:n, wtimeout:n} | {fsync:true}, default:false}, execute insert with a getLastError command returning the result of the insert command.
  #   readPreference {String}, the prefered read preference (ReadPreference.PRIMARY, ReadPreference.PRIMARY_PREFERRED, ReadPreference.SECONDARY, ReadPreference.SECONDARY_PREFERRED, ReadPreference.NEAREST).
  #   native_parser {Boolean, default:false}, use c++ bson parser.
  #   forceServerObjectId {Boolean, default:false}, force server to create _id fields instead of client.
  #   pkFactory {Object}, object overriding the basic ObjectID primary key generation.
  #   serializeFunctions {Boolean, default:false}, serialize functions.
  #   raw {Boolean, default:false}, peform operations using raw bson buffers.
  #   recordQueryStats {Boolean, default:false}, record query statistics during execution.
  #   reaper {Boolean, default:false}, enables the reaper, timing out calls that never return.
  #   reaperInterval {Number, default:10000}, number of miliseconds between reaper wakups.
  #   reaperTimeout {Number, default:30000}, the amount of time before a callback times out.
  #   retryMiliSeconds {Number, default:5000}, number of miliseconds between retries.
  #   numberOfRetries {Number, default:5}, number of retries off connection.
  @getDbInstance: (host, dbName, port, options = {safe:true}) ->
    if MongoGateway.db is undefined
      options.logger = MongoGateway.getLogger()
      dbServer = new Server host, port
      MongoGateway.db = new Db dbName, dbServer, options
    return MongoGateway.db


  @connect: (host, dbName, port, option, username, password) ->
    # open() calls server.connect() internally
    MongoGateway.getDbInstance(host, dbName, port, option)
      .open (err, Db) ->
        if err? then throw new Error "error #{err} when opening a connection", 500

        if username? and password?
          Db.authenticate username, password, (err, result) ->
            if err? or result is false or result is null
              throw new Error "error #{err} authenticating with: #{username}:#{password}", 500

  # @param {String} targetCollection
  # @param {Object} data
  # Options
  #   w, {Number/String, > -1 || ‘majority’ || tag name} the write concern for the operation where &lt; 1 is no acknowlegement of write and w >= 1, w = ‘majority’ or tag acknowledges the write
  #   wtimeout, {Number, 0} set the timeout for waiting for write concern to finish (combines with w option)
  #   fsync, (Boolean, default:false) write waits for fsync before returning
  #   journal, (Boolean, default:false) write waits for journal sync before returning
  #   continueOnError/keepGoing {Boolean, default:false}, keep inserting documents even if one document has an error, mongodb 1.9.1 >.
  #   serializeFunctions {Boolean, default:false}, serialize functions on the document.
  # @param {Function} callback
  @insert: (targetCollection, data, options, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    insertOptions =
      w: options.w ?= 1

    MongoGateway.db.collection(targetCollection).
      insert data, insertOptions, callback

  # @param {String} targetCollection
  # @param {Object} query
  # @param {Object} options
  # @param {Function} callback
  @findOne: (targetCollection, query, options, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    query = MongoGateway.convertId query
    query = MongoGateway.useObjectID query

    MongoGateway.db.collection(targetCollection).findOne query, options, callback

  # @param {String} targetCollection
  # @param {Object} query
  # @param {Object} fields
  # @param {Object} options
  # Options
  #   limit {Number, default:0}, sets the limit of documents returned in the query.
  #   sort {Array | Object}, set to sort the documents coming back from the query. Array of indexes, [[‘a’, 1]] etc.
  #   fields {Object}, the fields to return in the query. Object of fields to include or exclude (not both), {‘a’:1}
  #   skip {Number, default:0}, set to skip N documents ahead in your query (useful for pagination).
  #   hint {Object}, tell the query to use specific indexes in the query. Object of indexes to use, {‘_id’:1}
  #   explain {Boolean, default:false}, explain the query instead of returning the data.
  #   snapshot {Boolean, default:false}, snapshot query.
  #   timeout {Boolean, default:false}, specify if the cursor can timeout.
  #   tailable {Boolean, default:false}, specify if the cursor is tailable.
  #   tailableRetryInterval {Number, default:100}, specify the miliseconds between getMores on tailable cursor.
  #   numberOfRetries {Number, default:5}, specify the number of times to retry the tailable cursor.
  #   awaitdata {Boolean, default:false} allow the cursor to wait for data, only applicable for tailable cursor.
  #   exhaust {Boolean, default:false} have the server send all the documents at once as getMore packets, not recommended.
  #   batchSize {Number, default:0}, set the batchSize for the getMoreCommand when iterating over the query results.
  #   returnKey {Boolean, default:false}, only return the index key.
  #   maxScan {Number}, Limit the number of items to scan.
  #   min {Number}, Set index bounds.
  #   max {Number}, Set index bounds.
  #   showDiskLoc {Boolean, default:false}, Show disk location of results.
  #   comment {String}, You can put a $comment field on a query to make looking in the profiler logs simpler.
  #   raw {Boolean, default:false}, Return all BSON documents as Raw Buffer documents.
  #   readPreference {String}, the preferred read preference ((Server.PRIMARY, Server.PRIMARY_PREFERRED, Server.SECONDARY, Server.SECONDARY_PREFERRED, Server.NEAREST).
  #   numberOfRetries {Number, default:5}, if using awaidata specifies the number of times to retry on timeout.
  #   partial {Boolean, default:false}, specify if the cursor should return partial results when querying against a sharded system
  # @param {Function} callback
  @find: (targetCollection, query, fields, options, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    callback null, MongoGateway.db.collection(targetCollection).
      find(query, fields, options)

  # @param {String} targetCollection
  # @param {Object} whereQuery
  # @param {Object} updateQuery
  # @param {Object} options
  # Options
  #   w, {Number/String, > -1 || ‘majority’ || tag name} the write concern for the operation where &lt; 1 is no acknowlegement of write and w >= 1, w = ‘majority’ or tag acknowledges the write
  #   wtimeout, {Number, 0} set the timeout for waiting for write concern to finish (combines with w option)
  #   fsync, (Boolean, default:false) write waits for fsync before returning
  #   journal, (Boolean, default:false) write waits for journal sync before returning
  #   upsert {Boolean, default:false}, perform an upsert operation.
  #   multi {Boolean, default:false}, update all documents matching the selector.
  #   serializeFunctions {Boolean, default:false}, serialize functions on the document.
  # @param {Function} callback
  @update: (targetCollection, whereQuery, updateQuery, options, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    collection = MongoGateway.db.collection targetCollection

    updateOptions =
      multi: options.multi ?= false
      upsert: options.upsert ?= false
      w: options.w ?= 1
    whereQuery = MongoGateway.convertId whereQuery
    whereQuery = MongoGateway.useObjectID whereQuery
    updateQuery = MongoGateway.removeIdFromUpdate updateQuery

    collection.update whereQuery, updateQuery, updateOptions, callback

  # @param {String} targetCollection
  # @param {Object} document
  # @param {Object} options
  # Options
  #   **w**, {Number/String, > -1 || 'majority' || tag name} the write concern for the operation where < 1 is no acknowlegement of write and w >= 1, w = 'majority' or tag acknowledges the write
  #   **wtimeout**, {Number, 0} set the timeout for waiting for write concern to finish (combines with w option)
  #   **fsync**, (Boolean, default:false) write waits for fsync before returning
  #   **journal**, (Boolean, default:false) write waits for journal sync before returning
  # @param {Function} callback
  @save: (targetCollection, document, options, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'

    # @TODO callback depends on the value of w
    # add a switch to create different callbacks 
    # in order to log possible errors
    #
    # example with w > 1
    # (err, numUpdates, info) -> console.log err, numUpdates, info

    # MongoGateway.db.collection(targetCollection)
    #   .save document, {w: options.w ?= false}, callback
    MongoGateway.db.collection(targetCollection)
      .save document, {w: options.w ?= 1}, callback

  # @param {String} targetCollection
  # @param {Object} whereQuery
  # @param {Function} callback
  @remove: (targetCollection, whereQuery, callback) ->
    throw new Error 'Invalid callback' unless typeof callback is 'function'
    whereQuery = MongoGateway.convertId whereQuery
    whereQuery = MongoGateway.useObjectID whereQuery
    MongoGateway.db.collection(targetCollection).
      remove whereQuery, {safe: 1}, callback


  @findAndModify: (targetCollection, whereQuery, sort, doc, options, callback) ->
    MongoGateway.db.collection(targetCollection).
      findAndModify whereQuery, sort, doc, options, callback


  # Convert id to _id
  @convertId: (query) ->
    for k, v of query
      if k is 'id'
        query._id = query.id
        delete query.id
    return query

  # cast id to ObjectId
  @useObjectID: (query) ->
    if query._id?
      query._id = new ObjectID query._id unless query._id instanceof ObjectID
    return query

  # mongo native driver fails when the update contains an objectid
  @removeIdFromUpdate: (updateQuery) ->
    delete updateQuery['$set']._id if updateQuery['$set']?._id?
    return updateQuery

module.exports = MongoGateway
