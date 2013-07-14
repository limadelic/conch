define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.View

    el: 'body'

    initialize: ->
      window.shell = @