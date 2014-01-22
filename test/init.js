require('rootpath')()

var User  = require('src/model/User');
var userMapper = require('src/mapper/user');
var scoreMapper = require('src/mapper/score');

var mockUsers = require('test/data/db/user').getData()
var mockScores = require('test/data/db/score').getData()

global.log = {
  error: console.error,
  warn: function () {return},
  debug: function () {return},
  info: function () {return},
  trace: function () {return},
  fatal: function () {return},
  child: function () {return this}
};


global.userFactory = function( firstName, lastName ) {

  if (firstName == null) {
    firstName = mockUsers.validUser1.first_name
  }

  if (lastName == null) {
    lastName = mockUsers.validUser1.last_name
  }

  var u = new User( {first_name: firstName, last_name: lastName})
  u.id = mockUsers.validUser1._id.toHexString()
  return u
};

global.scoreFactory = function( type ) {

  if (type == null) {
    type = 'Indoor 18m'
  }

  return scoreMapper.unmarshall( mockScores[type][0] );

}

global.allTypes = [undefined, null, false, 1, 1385668252435, NaN, '', [], {}, new Object(), new Date(), function() {}]
global.allNotStringTypes = [undefined, null, false, 1, 1385668252435, NaN, [], {}, new Object(), new Date(), function() {}]
global.allNotFunctionTypes = [undefined, null, false, 1, 1385668252435, NaN, '', [], {}, new Object(), new Date()]
global.allNotUndefinedTypes = [false, 1, 1385668252435, NaN, '', [], {}, new Object(), new Date(), function() {}]
global.allNotObjectTypes = [undefined, null, false, 1, 1385668252435, NaN, '', [], new Date, function() {}]
global.allNotDatesTypes = [undefined, null, false, 1, 1385668252435, NaN, '', [], {}, new Object(), function() {}]
global.allNotNumbersTypes = [undefined, null, false, NaN, '', [], {}, new Object(), new Date(), function() {}]
