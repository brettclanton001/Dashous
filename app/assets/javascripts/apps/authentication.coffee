class Dashous.Apps.Authentication extends Dashous.Apps.Base

  initialize: ->

  onStart: (@data) ->
    @initRegions()
    new Dashous.Routers.Authentication @, @data

  initRegions: ->
    @addRegions
      mainRegion: '#main-region'
