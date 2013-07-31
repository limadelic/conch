WSocket = require 'ws'

global.WebSocket = class

  constructor: (url) ->
    @ws = new WSocket url
    @ws.on 'message', @on_message

  on_message: (msg) => @onmessage data: msg

  send: (msg) -> @ws.send msg