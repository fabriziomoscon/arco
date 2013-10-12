#> test a 404 page
path: '/users'
method: 'GET'
headers:
  'Accept': 'text/html'
  'Content-Type': 'application/json'

#? response 406
response.statusCode.should.equal 406

#? no error
should.not.exist json.error
