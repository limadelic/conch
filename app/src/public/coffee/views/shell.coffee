define [
  'underscore'
  'backbone'
  'autosize'
],

(_, Backbone) ->

  class Shell extends Backbone.View

    el: 'body'

    events:
      'keypress': 'keypress'

    initialize: ->
      window.shell = @

      @cmd = @$ '#cmd'
      @cmd.autosize()

      @out = @$ '#out'
      @model.out = (log) => @out.text log

    render: ->
      @cmd.focus()
      @

    keypress: (@e) ->
      @run() or @cmd.focus()

    run: ->
      return unless @e.keyCode is 13

      @model.cmd = @cmd.val()
      @model.run()

      @cmd.val ''
      @e.preventDefault()
