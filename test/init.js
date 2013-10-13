require('rootpath')()

global.log = {
  error: console.error,
  warn: function () {return},
  debug: function () {return},
  info: function () {return},
  trace: function () {return},
  fatal: function () {return},
  child: function () {return this}
};

User = require('src/model/User');

global.userFactory = function( firstName, lastName ) {

  var mockUser = require('test/data/db/user').getData().validUser1
  if (firstName == null) {
    firstName = mockUser.first_name
  }

  if (lastName == null) {
    lastName = mockUser.last_name
  }

  var u = new User( {first_name: firstName, last_name: lastName})
  u.setId(mockUser._id.toHexString())
  return u
};

global.allTypes = [undefined, null, false, 1, NaN, '', [], {}, new Object(), new Date(), function() {}]
global.allTypesNotString = [undefined, null, false, 1, NaN, [], {}, new Object(), new Date(), function() {}]
global.allNotFunctionTypes = [undefined, null, false, 1, NaN, '', [], {}, new Object(), new Date()]
global.allNotUndefinedTypes = [false, 1, NaN, '', [], {}, new Object(), new Date(), function() {}]
global.allNotObjectTypes = [undefined, null, false, 1, NaN, '', [], new Date, function() {}]
