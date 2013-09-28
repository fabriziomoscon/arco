#> login success
path: '/auth/login'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body:
  email: 'fab@coffeestack.com'
  password: 'qwerty21'


#? Status: 200
response.statusCode.should.equal 200

#? Should set a cookie
response.should.have.header 'Set-Cookie'

#? Response.user should exist
should.exist json

#? user properties
should.exist json.id
should.exist json.first_name
should.exist json.last_name
should.exist json.email

