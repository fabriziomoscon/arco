deepClone = require 'src/lib/utils/deepClone'

users = require('test/data/db/user').getData()
places = require('test/data/db/place').getData()
matches = require('test/data/db/match').getData()

ObjectID = require('mongodb').ObjectID

ids = 
  validIdString1: '5aa896ddc814556766002001'
  validIdString2: '5aa896ddc814556766002002'
  validIdString3: '5aa896ddc814556766002003'
  validIdString4: '5aa896ddc814556766002004'
  validIdString5: '5aa896ddc814556766002005'
  validIdString6: '5aa896ddc814556766002006'
  validIdString6: '5aa896ddc814556766002007'
  validIdString6: '5aa896ddc814556766002008'
  validIdString6: '5aa896ddc814556766002009'


data =

  validScore1:
    _id: new ObjectID(ids.validIdString1)
    user_id: users.validUser1
    type: 'FITA 90+70+50+30'
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace1
    partials:
      '90': 300
      '70': 320
      '50': 325
      '30': 340
    arrows:
      '90': [
        10, 9, 8, 8, 8, 7,
        10, 9, 8, 8, 8, 7,
        10, 9, 8, 8, 8, 7,
        10, 9, 8, 8, 8, 7,
        10, 9, 8, 8, 8, 7,
        10, 9, 8, 8, 8, 7,
      ]
      '70': []
      '50': []
      '30': []
    total: 1285
    match_id: matches.validMatch1._id
  
  validScore2:
    _id: new ObjectID(ids.validIdString2)
    user_id: users.validUser2
    type: 'Indoor 18'
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace2
    partials:
      first: 280
      second: 290 
    arrows: []
    total: 570
    match_id: matches.validMatch1._id
  
  validScore3:
    _id: new ObjectID(ids.validIdString3)
    user_id: users.validUser3
    type: 'H+F 24+24'
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace3
    partials:
      hunter: 310
      field: 320
    arrows: []
    total: 630
    match_id: matches.validMatch1._id

  validScore4:
    _id: new ObjectID(ids.validIdString4)
    user_id: users.validUser4
    type: '70m qualification'
    times:
      created: new Date 2013, 1, 1
    places:
      location: places.validPlace4
    partials:
      first: 300
      second: 320
    arrows: []
    total: 620
    match_id: matches.validMatch1._id


module.exports.getData = () -> deepClone data
