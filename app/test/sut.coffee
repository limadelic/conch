global.new_sut = (file) ->
  beforeEach (done) ->
    requirejs ["cs!#{file}"], (Sut) ->
      global.sut = new Sut
      done()