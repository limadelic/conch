define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    run: (cmd, output) ->
      output 'dir ...'