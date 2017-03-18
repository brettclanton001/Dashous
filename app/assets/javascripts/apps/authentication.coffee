class Dashous.Apps.Authentication extends Dashous.Apps.Base

  initialize: ->

  onStart: (@data) ->
    @initRegions()
    @initRouter()
    @initHistory()

  initRouter: ->
    new Dashous.Routers.Authentication @, @data

  initHistory: ->
    Backbone.history.start pushState: true

  initRegions: ->
    @addRegions
      mainRegion: '#main-region'
