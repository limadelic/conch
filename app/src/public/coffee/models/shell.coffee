define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    constructor: ->
      @socket = new WebSocket 'ws://localhost:8888'

    run: (cmd, out) ->
      @[cmd]?()
      @socket.onmessage = out
      @socket.send cmd

    exit: -> window.close()

