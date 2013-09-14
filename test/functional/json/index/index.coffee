#> Index success
path: '/'
method: 'GET'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'

#? Status: 200
response.statusCode.should.equal 200

#? Should set a cookie
response.should.have.header 'Set-Cookie'
