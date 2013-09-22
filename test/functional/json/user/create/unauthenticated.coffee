#> Create user unauthenticated
path: '/user'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body:
  first_name: 'Fabrizio'
  last_name: 'Moscon'
  email: "fab+#{Date.now()}@coffeestack.com"
  password: 'mySecretPass'

#? status: 401
response.statusCode.should.eql 401

#? error message
json.error.should.eql 'unauthenticated'
