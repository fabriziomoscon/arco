deepClone = require 'src/lib/utils/deepClone'

ObjectID = require('mongodb').ObjectID

ids = 
  validIdString1: '5aa896ddc814556766003001'
  validIdString2: '5aa896ddc814556766003002'
  validIdString3: '5aa896ddc814556766003003'
  validIdString4: '5aa896ddc814556766003004'
  validIdString5: '5aa896ddc814556766003005'
  validIdString6: '5aa896ddc814556766003006'
  validIdString6: '5aa896ddc814556766003007'
  validIdString6: '5aa896ddc814556766003008'
  validIdString6: '5aa896ddc814556766003009'


data =

  validPlace1:
    _id: new ObjectID(ids.validIdString1)
    geolocation: { type: 'Point', coordinates: [ 0, 0 ] }
    country: ''
    countryCode: ''
    postCode: ''
    type: ''
    streetNumber: ''
    streetName: ''
    city: ''
    containers: []
    poi: ''
  
  validPlace2:
    _id: new ObjectID(ids.validIdString2)
    geolocation: { type: 'Point', coordinates: [ 0, 0 ] }
    country: ''
    countryCode: ''
    postCode: ''
    type: ''
    streetNumber: ''
    streetName: ''
    city: ''
    containers: []
    poi: ''
  
  validPlace3:
    _id: new ObjectID(ids.validIdString3)
    geolocation: { type: 'Point', coordinates: [ 0, 0 ] }
    country: ''
    countryCode: ''
    postCode: ''
    type: ''
    streetNumber: ''
    streetName: ''
    city: ''
    containers: []
    poi: ''

  validPlace4:
    _id: new ObjectID(ids.validIdString4)
    geolocation: { type: 'Point', coordinates: [ 0, 0 ] }
    country: ''
    countryCode: ''
    postCode: ''
    type: ''
    streetNumber: ''
    streetName: ''
    city: ''
    containers: []
    poi: ''


module.exports.getData = () -> deepClone data
