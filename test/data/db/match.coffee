deepClone = require 'src/lib/utils/deepClone'

users  = require('test/data/db/user').getData()
places = require('test/data/db/place').getData()
scores = require('test/data/db/score').getData()

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
    type: 'FITA 90+70+50+30'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace1
    score_ids: [scores['FITA 90+70+50+30'][0]._id]
  
  validMatch2:
    _id: new ObjectID(ids.validIdString2)
    name: 'Indoor match example 1'
    type: 'Indoor 18m'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace2
    score_ids: [scores['Indoor 18m'][0]._id]
  
  validMatch3:
    _id: new ObjectID(ids.validIdString3)
    name: 'Hunter match example 1'
    type: 'H+F 24+24'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace3
    score_ids: [scores['H+F 24+24'][0]._id]

  validMatch4:
    _id: new ObjectID(ids.validIdString4)
    name: '70 OR match example 1'
    type: '70m qualification'
    participants: [
      users.validUser1, users.validUser2
    ]
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace4
    score_ids: [scores['70m qualification'][0]._id]


module.exports.getData = () -> deepClone data
