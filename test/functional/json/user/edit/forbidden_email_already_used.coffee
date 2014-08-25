#> edit user forbidden to use an email already used
path: '/user/me'
method: 'PUT'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[1]
body:
  email: 'ismini@coffestack.com'
  first_name: 'Fab'
  last_name: 'Mos'

#? response status 403
response.statusCode.should.equal 403

#? error message
should.exist json.error

#? error code
should.exist json.error_code
json.error_code.should.equal 1028
