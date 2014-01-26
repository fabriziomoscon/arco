deepClone = require 'src/lib/utils/deepClone'

places = require('test/data/db/place').getData()

ObjectID = require('mongodb').ObjectID

ids = 
  validIdString1: '50b896ddc814556766000001'
  validIdString2: '50b896ddc814556766000002'
  validIdString3: '50b896ddc814556766000003'
  validIdString4: '50b896ddc814556766000004'
  validIdString5: '50b896ddc814556766000005'
  validIdString6: '50b896ddc814556766000006'
  validIdString7: '50b896ddc814556766000007'
  validIdString8: '50b896ddc814556766000008'
  validIdString9: '50b896ddc814556766000009'


data =

  validUser1:
    _id: new ObjectID( ids.validIdString1 )
    first_name: 'fabrizio'
    last_name: 'moscon'
    email: 'fab@coffeestack.com'
    password: 'qwerty21'
    gender: 'M'
    birthdate: new Date 1983, 5, 6
    times:
      created: new Date 2012, 1, 1

  validUser2:
    _id: new ObjectID( ids.validIdString2 )
    first_name: 'peter'
    last_name: 'johnson'
    email: 'peter@coffestack.com'
    password: 'qwerty21'
    gender: 'M'
    birthdate: new Date 1983, 0, 25
    times:
      created: new Date 2012, 11, 7

  validUser3:
    _id: new ObjectID( ids.validIdString3 )
    first_name: 'ismini'
    last_name: 'chatzitheofilou'
    email: 'ismini@coffestack.com'
    password: 'qwerty21'
    gender: 'F'
    birthdate: new Date 1986, 10, 6
    times:
      created: new Date 2012, 11, 7

  validUser4:
    _id: new ObjectID( ids.validIdString4 )
    first_name: 'sixto'
    last_name: 'rodriguez'
    email: 'sixto@coffestack.com'
    password: 'qwerty21'
    gender: 'M'
    birthdate: new Date 1942, 6, 10
    times:
      created: new Date 2012, 11, 7


module.exports.getData = () -> deepClone data
