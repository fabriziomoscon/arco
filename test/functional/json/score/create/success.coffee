#> Create new score success
path: '/score'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[0]
body:
  type: 'H+F 12+12'

#? Status: 201 created
response.statusCode.should.equal 201

#? Response.user should exist
should.exist json

#? score properties
console.log json
should.exist json.id
should.exist json.type
should.exist json.user_id
should.exist json.times
# should.exist json.places
should.exist json.partials
