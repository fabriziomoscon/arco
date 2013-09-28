#> login unauthorized
path: '/auth/login'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body:
  email: 'fab@coffeestack.com'
  password: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'


#? Status: 401
response.statusCode.should.equal 401

#? Should not set a cookie
response.should.not.have.header 'Set-Cookie'

#? error message
json.error.should.equal 'Wrong email or password'

#? error code
json.error_code.should.equal 2002
