#> Create new score success
path: '/score'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
  'Cookie': config.system_users[0]
body:
  type: 'FITA 90+70+50+30'
  total: '1300'

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

#? return correct type
json.type.should.equal 'FITA 90+70+50+30'

#? return correct total
console.log json
json.total.should.equal 1300
