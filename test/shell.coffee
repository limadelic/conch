describe 'Shell', ->

  new_sut 'models/shell'

  it 'dir', (done) ->

    $ 'dir', (out) ->
      out.should.match /Directory of C\:/
      done()

#  describe 'ctrl+c', ->
#
#    it 'breaks running proccesses', (done) ->
#
#      $ 'ping localhost /t', (out) ->
#        out.should.match /Control-C/
#        done()
#
#      setTimeout(
#        -> $ '^C'
#        3000
#      )

  describe 'cd', ->

    it 'show dir on title', ->
      document.title.should.match /conch$/

    it 'change title and dir', (done) ->

      $ 'cd client', ->
        document.title.should.match /client$/
        $ 'dir', (out) ->
          out.should.match /Gemfile/
          done()

    it 'on error keep dir and show message', (done) ->
      original_title = document.title

      $ 'cd crap', (out) ->
        document.title.should.eql original_title
        out.should.match /cannot find/
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
