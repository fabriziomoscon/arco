deepClone = require 'src/lib/utils/deepClone'

users = require('test/data/db/user').getData()
places = require('test/data/db/place').getData()

ObjectID = require('mongodb').ObjectID

ids = 
  validIdString1: '5aa896ddc814556766001001'
  validIdString2: '5aa896ddc814556766001002'
  validIdString3: '5aa896ddc814556766001003'
  validIdString4: '5aa896ddc814556766001004'
  validIdString5: '5aa896ddc814556766001005'
  validIdString6: '5aa896ddc814556766001006'
  validIdString6: '5aa896ddc814556766001007'
  validIdString6: '5aa896ddc814556766001008'
  validIdString6: '5aa896ddc814556766001009'


data =

  validMatch1:
    _id: new ObjectID(ids.validIdString1)
    name: 'Outdoor match example 1'
    type: 'FITA'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace1
  
  validMatch2:
    _id: new ObjectID(ids.validIdString2)
    name: 'Indoor match example 1'
    type: 'Indoor 18'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace2
  
  validMatch3:
    _id: new ObjectID(ids.validIdString3)
    name: 'Hunter match example 1'
    type: 'H+F'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace3

  validMatch4:
    _id: new ObjectID(ids.validIdString4)
    name: 'Hunter match example 1'
    type: '70m qualification'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace4


module.exports.getData = () -> deepClone data
