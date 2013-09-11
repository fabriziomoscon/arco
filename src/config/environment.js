/**
 * Loads up configuration from the enviroment
 * No coffee-script here so it can be used anywhere, anytime
 */

var yapec = require('yapec')
var configs = require('./namespace')

var masterConfig = {}

configs.forEach(function(config){
  masterConfig[config.name] = yapec(config.prefix, require('./env/'+config.name), process.env, config.opts)
})

module.exports = masterConfig
