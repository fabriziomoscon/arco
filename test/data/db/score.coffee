deepClone = require 'src/lib/utils/deepClone'

users = require('test/data/db/user').getData()
places = require('test/data/db/place').getData()

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

  'FITA 90+70+50+30': [
    {
      _id: new ObjectID(ids.validIdString1)
      user_id: users.validUser1._id
      type: 'FITA 90+70+50+30'
      times:
        created: new Date 2013, 1, 1
      places:
        address: places.validPlace1
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
    }
  ]
  
  'Indoor 18m': [
    {
      _id: new ObjectID(ids.validIdString2)
      user_id: users.validUser2._id
      type: 'Indoor 18m'
      times:
        created: new Date 2013, 1, 1
      places:
        address: places.validPlace2
      partials:
        first: 61
        second: 45
      arrows:
        first: [10, 6, 9, 6, 10, 2, 0, 10, 8]
        second: [8, 4, 5, 8, 1, 0, 10, 9]
      total: 106
    }
  ]
  
  'H+F 24+24': [
    {
      _id: new ObjectID(ids.validIdString3)
      user_id: users.validUser3._id
      type: 'H+F 24+24'
      times:
        created: new Date 2013, 1, 1
      places:
        address: places.validPlace3
      partials:
        hunter: 310
        field: 320
      arrows: {}
      total: 630
    }
  ]

  '70m qualification': [
    {
      _id: new ObjectID(ids.validIdString4)
      user_id: users.validUser4._id
      type: '70m qualification'
      times:
        created: new Date 2013, 1, 1
      places:
        address: places.validPlace4
      partials:
        first: 300
        second: 320
      arrows: {}
      total: 620
    }
  ]


module.exports.getData = () -> deepClone data
