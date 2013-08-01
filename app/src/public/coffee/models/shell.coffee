define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    constructor: ->
      @socket = new WebSocket 'ws://localhost:8888'
      @socket.onmessage = @connect
      @log = ''

    connect: (msg) =>
      document.title = @cwd = msg.data
      @socket.onmessage = @log_msg

    run: (@cmd) ->
      @run_on_browser() or
      @run_on_client()

    run_on_client: ->
      @socket.send JSON.stringify
        cmd: @cmd
        cwd: @cwd

    run_on_browser: ->
      return true if @cmd.length is 0
      return unless @cmd in ['exit', 'cls']
      @[@cmd]()

    exit: -> window.close()

    cls: ->
      @out @log = ''
      true

    log_msg: (msg) => @out @log = """
      >#{@cmd}
      #{msg.data}
      #{@log}
    """
