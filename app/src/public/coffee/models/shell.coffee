define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    constructor: ->
      @socket = new WebSocket 'ws://localhost:8888'

    run: (cmd, out) -> @socket.onopen =>
      @socket.onmessage out
      @socket.send cmd


