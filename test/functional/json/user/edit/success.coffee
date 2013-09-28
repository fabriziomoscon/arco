#> edit user success
path: '/user/me'
method: 'PUT'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[0]
body:
  first_name: 'Fab'
  last_name: 'Mos'

#? response status 200
response.statusCode.should.equal 200

#? first_name changed
json.first_name.should.equal 'Fab'

#? last_name changed
json.last_name.should.equal 'Mos'
