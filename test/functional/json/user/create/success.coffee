#> Create user success
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


#? Status: 201 created
response.statusCode.should.equal 201

#? Should set a cookie
response.should.have.header 'Set-Cookie'

#? Response.body should exist
should.exist json.body

#? Response.body.user should exist
should.exist json.body.user

#? user properties
should.exist json.body.user.id
should.exist json.body.user.first_name
should.exist json.body.user.last_name
should.exist json.body.user.email