describe 'Shell', ->

  new_sut 'models/shell'

  it 'run dir', (done) ->

    sut.run 'dir', (output) ->
      output.should.match /Directory of C\:/
      done()
