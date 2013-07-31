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
      'keyup': 'keyup'

    initialize: ->
      window.shell = @

      @cmd = @$ '#cmd'
      @cmd.autosize()

      @out = @$ '#out'
      @model.out = (log) => @out.text log

    render: ->
      @cmd.focus()
      @

    keypress: (@e) -> @run() or @cmd.focus()
    keyup: (@e) -> @esc()

    run: ->
      return unless @e.keyCode is 13
      @model.run @cmd.val()
      @clear()

    esc: -> @clear() if @e.keyCode is 27

    clear: ->
      @cmd.val ''
      @e.preventDefault()
