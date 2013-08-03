define [
  'underscore'
  'backbone'
],

(_, Backbone) ->

  class Shell extends Backbone.Model

    constructor: ->
      @socket = new WebSocket 'ws://localhost:8888'
      @expect @connect
      @log = ''

    expect: (do_something) ->
      @socket.onmessage = do_something

    connect: (msg) =>
      document.title = @cwd = msg.data
      @expect @console_log

    run: (@cmd) ->
      @run_on_browser() or
      @run_on_client()

    run_on_client: ->
      @socket.send JSON.stringify
        cmd: @cmd
        cwd: @cwd

    run_on_browser: ->
      return true if @cmd.length is 0
      cmd = @parse_cmd()
      return unless cmd in ['exit', 'cls', 'cd']
      @[cmd].apply @, args

    parse_cmd: -> @cmd.split(' ')[0]

    cd: -> @expect @new_cwd
    new_cwd: (@cwd) => @expect @console_log

    exit: -> window.close()

    cls: ->
      @out @log = ''
      true

    console_log: (msg) => @out @log = """
      >#{@cmd}
      #{msg.data}
      #{@log}
    """
