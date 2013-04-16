config =

  development:
    db:
      protocol: "mongodb"
      host:     "127.0.0.1"
      dbName:   "coffeestackDB"
      port:     27017
      user:     null
      password: null
    server:
      domain: "yourproject.com"
      auth:
        salt: "<SOME_SALT>"
      listenPort: 3000
      session:
        secret: "<SESSION_SECRET>"
      oauth:
        facebook:
          id: ''
          secret: ''
          redirectUri: ''
        google:
          id: ''
          secret: ''
          redirectUri: ''
    client:
      seo:
        title: 'CoffeeStack'
      google:
        maps:
          key: ''

  testing:
    db:
      protocol: "mongodb"
      host:     "127.0.0.1"
      dbName:   "coffeestackDB"
      port:     27017
      user:     null
      password: null
    server:
      domain: "yourproject.com"
      auth:
        salt: "<SOME_SALT>"
      listenPort: 4000
      session:
        secret: "<SESSION_SECRET>"
      oauth:
        facebook:
          id: ''
          secret: ''
          redirectUri: ''
        google:
          id: ''
          secret: ''
          redirectUri: ''
    client:
      seo:
        title: 'CoffeeStack'
      google:
        maps:
          key: ''

  staging:
    db:
      protocol: "mongodb"
      host:     "127.0.0.1"
      dbName:   "coffeestackDB"
      port:     27017
      user:     null
      password: null
    server:
      domain: "yourproject.com"
      auth:
        salt: "<SOME_SALT>"
      listenPort: 3000
      session:
        secret: "<SESSION_SECRET>"
      oauth:
        facebook:
          id: ''
          secret: ''
          redirectUri: ''
        google:
          id: ''
          secret: ''
          redirectUri: ''
    client:
      seo:
        title: 'CoffeeStack'
      google:
        maps:
          key: ''

  production:
    db:
      protocol: "mongodb"
      host:     "127.0.0.1"
      dbName:   "coffeestackDB"
      port:     27017
      user:     null
      password: null
    server:
      domain: "yourproject.com"
      auth:
        salt: "<SOME_SALT>"
      listenPort: 3000
      session:
        secret: "<SESSION_SECRET>"
      oauth:
        facebook:
          id: ''
          secret: ''
          redirectUri: ''
        google:
          id: ''
          secret: ''
          redirectUri: ''
    client:
      seo:
        title: 'CoffeeStack'
      google:
        maps:
          key: ''

module.exports = (environment) ->
  throw new Error 'Environment not found' unless environment? and config[environment]?
  return config[environment]