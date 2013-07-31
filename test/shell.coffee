describe 'Shell', ->

  new_sut 'models/shell'

  it 'run dir', (done) ->

    $ 'dir', (out) ->
      out.should.match /Directory of C\:/
      done()

  describe 'exit', ->

    it 'closes the browser', (done) ->
      global.window = close: done
      $ 'exit'