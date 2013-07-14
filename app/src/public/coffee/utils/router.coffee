define [
  'underscore'
  'backbone'
  'cs!models/shell'
  'cs!views/shell'
],

(_, Backbone, Model, View) ->

  class Router extends Backbone.Router

    initialize: ->
      @shell = new View
        model: new Model
      Backbone.history.start()
      @

    routes:
      '': 'index'

    index: -> @shell.render()



