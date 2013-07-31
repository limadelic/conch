describe 'Shell', ->

  new_sut 'models/shell'

  it 'run dir', (done) ->

    $ 'dir', (out) ->
      out.should.match /Directory of C\:/
      done()

  describe 'cls', ->
    
    it 'clears the output', (done) ->

      $ 'cls', (out) ->
        out.should.eql ''
        done()

  describe 'exit', ->

    it 'closes the browser', (done) ->

      global.window = close: done
      sut.run_on_client = ->

      $ 'exit'

    it 'closes the client', (done) ->

      global.window = close: ->
      sut.run_on_client = ->
        sut.cmd.should.eql 'exit'
        done()

      $ 'exit'
