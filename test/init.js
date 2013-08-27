require('rootpath')()

global.log = {
  error: function () {return;},
  warn: function () {return;},
  debug: function () {return;},
  info: function () {return;},
  trace: function () {return;},
  fatal: function () {return;},
  child: function () {return this}
}
