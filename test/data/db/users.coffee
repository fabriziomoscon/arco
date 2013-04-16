deepClone = require 'src/lib/utils/deepClone'

ObjectID = require('mongodb').ObjectID

ids = 
  validIdString1: '50b896ddc814556766000001'
  validIdString2: '50b896ddc814556766000002'
  validIdString3: '50b896ddc814556766000003'
  validIdString4: '50b896ddc814556766000004'
  validIdString5: '50b896ddc814556766000005'
  validIdString6: '50b896ddc814556766000006'

data =

  validUser1:
    _id: new ObjectID( ids.validIdString1 )
    first_name: 'fabrizio'
    last_name: 'moscon'
    email: 'fab@coffeestack.com'
    password: 'qwerty'
    created_at: new Date 2012, 1, 1

  validUser2:
    _id: new ObjectID( ids.validIdString2 )
    first_name: 'peter'
    last_name: 'johnson'
    email: 'peter@coffestack.com'
    password: 'qwerty'
    created_at: new Date 2012, 11, 7

module.exports.getData = -> deepClone data