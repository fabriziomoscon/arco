#> test a 404 page
path: '/non-existing-route'
method: 'GET'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'

#? response 404
response.statusCode.should.equal 404

#? no error
should.not.exist json.error
