define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.View

    el: 'body'

    initialize: ->
      window.shell = @

    render: ->
      @$('#cmd').focus()
      @$('#output').text('dir dir')
      @