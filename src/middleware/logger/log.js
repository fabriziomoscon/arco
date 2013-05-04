var Logger = require('bunyan');
// var bsyslog = require('bunyan-syslog');

module.exports = new Logger( {
  name: 'arco',
  streams: [
    {
      path: 'arco.fatal.log',
      level: 'fatal' 
    },
    {
      path: 'arco.err.log',
      level: 'error'
    },
    {
      type: 'rotating-file',
      path: 'arco.warn.log',
      period: '1d',    // daily rotation
      count: 10,       // keep 3 back copies
      level: 'warn'
    },
    {
      path: 'arco.info.log',
      level: 'info'
      // level: 'info',
      // type: 'raw',
      // stream: bsyslog.createBunyanStream({
      //   type: 'sys',
      //   facility: bsyslog.local0,
      //   host: '127.0.0.1',
      //   port: 8125
      // })
    },
    {
      stream: process.stdout,
      level: 'debug'
      // type: 'raw',
      // stream: bsyslog.createBunyanStream({
      //     type: 'sys',
      //     facility: bsyslog.local0,
      //     host: '127.0.0.1',
      //     port: 8125
      // })
    },
    {
      path: 'arco.trace.log',
      level: 'trace'
    }
  ],
  serializers: Logger.stdSerializers
// , src: true
});