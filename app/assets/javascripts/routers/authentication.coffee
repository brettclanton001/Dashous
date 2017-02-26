class Dashous.Routers.Authentication extends Backbone.Router

  constructor: (@app, @data) ->
    super({})

  initialize: ->
    @app.mainRegion.show new Dashous.Views.Authentication.Login()
