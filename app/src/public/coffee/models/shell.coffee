define [
  'underscore'
  'backbone'
  'socket.io-client'
],

(_, Backbone, io) ->

  class Shell extends Backbone.Model

    run: (cmd, output) ->
      socket = io.connect 'http://localhost'
      socket.on 'connect', ->
        output 'dir ...'