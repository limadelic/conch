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
      @focus()
      @

    typing: (e) ->
      if e.keyCode is 13
      then @run()
      else @focus()

    focus: ->
      return if @cmd.is ':focus'
      @cmd.focus()

    run: ->
      cmd = @cmd.val()
      @cmd.val ''
      @model.run cmd, (out) =>
        @write cmd, out.data

    write: (cmd, output) =>
      output += '\n' if output.length > 0
      @out.text @log = """
        > #{cmd}
        #{output}#{@log}
      """
