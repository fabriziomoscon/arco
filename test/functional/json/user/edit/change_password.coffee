#> edit user change password
path: '/user/me'
method: 'PUT'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[1]
body:
  password: 'myNewSuperSecretPassword'
  confirm_password: 'myNewSuperSecretPassword'

#? response status 200
response.statusCode.should.equal 200
