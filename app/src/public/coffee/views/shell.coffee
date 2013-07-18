define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.View

    el: 'body'

    events:
      'keypress #cmd': 'enter'

    initialize: ->
      window.shell = @
      @lines = ''
      @cmd = @$ '#cmd'
      @out = @$ '#output'

    render: ->
      @cmd.val ''
      @cmd.focus()
      @

    enter: (e) ->
      return unless e.keyCode is 13
      p cmd = @cmd.val()
      @model.run cmd, (out) =>
        @write cmd, out.data

    write: (cmd, msg) =>
      @out.text @lines = """
        > #{cmd}\n
        #{msg}\n
        #{@lines}
      """
      @render()
