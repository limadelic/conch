WSocket = require 'ws'

global.WebSocket = class

  constructor: (url) ->
    @ws = new WSocket url

  onopen: (open) -> @ws.on 'open', open
  onmessage: (open) -> @ws.on 'message', open
  onclose: (open) -> @ws.on 'close', open
  send: (msg) -> @ws.send msg