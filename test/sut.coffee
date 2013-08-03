global.new_sut = (file) ->
  beforeEach (done) ->
    requirejs ["cs!#{file}"], (Sut) ->
      global.sut = new Sut
      wait_for_client done

global.$ = (cmd, out) ->
  sut.out = out
  sut.run cmd

wait_for_client = (done) ->
  connect = sut.socket.onmessage
  sut.socket.onmessage = (msg) ->
    connect msg
    done()