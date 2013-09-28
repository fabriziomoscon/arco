#> edit user unauthorized
path: '/user/me'
method: 'PUT'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body:
  first_name: 'Fab'
  last_name: 'Mos'

#? response status 401
response.statusCode.should.equal 401

#? Should not set a cookie
response.should.not.have.header 'Set-Cookie'

#? error message
json.error.should.equal 'Please sign in to continue'

#? error code
json.error_code.should.equal 401
