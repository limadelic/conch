define [
  'underscore'
  'backbone'
  'autosize'
],

(_, Backbone) ->

  class Shell extends Backbone.View

    el: 'body'

    events:
      'keypress': 'typing'

    initialize: ->
      window.shell = @

      @cmd = @$ '#cmd'
      @cmd.autosize()

      @out = @$ '#output'
      @model.out = (log) => @out.text log

    render: ->
      @cmd.focus()
      @

    typing: (e) ->
      if e.keyCode is 13
        @run()
        e.preventDefault()
      else @cmd.focus()

    run: ->
      @model.cmd = @cmd.val()
      @cmd.val ''
      @model.run()
