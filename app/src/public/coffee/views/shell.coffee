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
      @log = ''
      @cmd = @$ '#cmd'
      @cmd.autosize()
      @out = @$ '#output'

    render: ->
      @cmd.focus()
      @

    typing: (e) ->
      if e.keyCode is 13
        @run()
        e.preventDefault()
      else @cmd.focus()

    run: ->
      cmd = @cmd.val()
      @cmd.val ''
      @model.run cmd, (out) =>
        @write cmd, out.data

    write: (cmd, output) =>
      output += '\n' if output.length > 0
      @out.text @log = """
        >#{cmd}
        #{output}#{@log}
      """
