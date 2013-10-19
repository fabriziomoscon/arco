#> create sccore unauthorized
path: '/score'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body:
  type: 'H+F 12+12'

#? response status 401
response.statusCode.should.equal 401

#? Should not set a cookie
response.should.not.have.header 'Set-Cookie'

#? error message
json.error.should.equal 'Please sign in to continue'

#? error code
json.error_code.should.equal 401
