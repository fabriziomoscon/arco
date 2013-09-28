#> Create user invalid data
path: '/user'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: {}

#? status: 400
response.statusCode.should.equal 400

#? error message
json.error.should.equal 'Invalid user data'

#? error code
json.error_code.should.equal 1010
