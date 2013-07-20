define [
  'underscore'
  'backbone'
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
      @out = @$ '#output'

    render: ->
      @cmd.val ''
      @cmd.focus()
      @

    typing: (e) ->
      @cmd.focus()
      @run() if e.keyCode is 13 

    run: ->
      cmd = @cmd.val()
      @model.run cmd, (out) =>
        @write cmd, out.data

    write: (cmd, output) =>
      output += '\n' if output.length > 0
      @out.text @log = """
        > #{cmd}
        #{output}#{@log}
      """
      @render()
