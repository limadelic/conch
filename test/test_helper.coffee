require './sut'

global.requirejs = require 'requirejs'

requirejs.config
  baseUrl: "#{__dirname}/../app/src/public/coffee/"
  nodeRequire: require
  paths:
    cs: '../js/cs'

global.p = (x) -> console.log JSON.stringify x
global.m = (x) -> p (name for name of x)

require './websocket'

global.document = {}
global.window = close: ->
global.set_timeout = (delay, func) ->
  setTimeout func, delay * 1000
