global.new_sut = (file) ->

  beforeEach (done) ->
    requirejs ["cs!#{file}"], (Sut) ->
      global.Sut = Sut
      global.sut = new Sut
      wait_for_client done

  after (done) ->
    $ 'exit'
    setTimeout done, 500


global.$ = (cmd, out) ->
  sut.out = out
  sut.run cmd

wait_for_client = (done) ->
  connect = sut.socket.onmessage
  sut.socket.onmessage = (msg) ->
    connect msg
    done()
