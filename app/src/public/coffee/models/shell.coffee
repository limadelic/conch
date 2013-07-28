define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    constructor: ->
      @socket = new WebSocket 'ws://localhost:8888'
      @socket.onmessage = @log_msg
      @log = ''

    run: ->
      @run_cmd() or
      @socket.send @cmd

    run_cmd: ->
      return true if @cmd.length is 0
      return unless @cmd in ['exit', 'cls']
      @[@cmd]()

    exit: -> window.close()
    cls: -> @out @log = ''

    log_msg: (msg) => @out @log = """
      >#{@cmd}
      #{msg.data}
      #{@log}
    """
