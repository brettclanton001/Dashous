class Dashous.Routers.Authentication extends Dashous.Routers.Base

  routes:
    'login': 'login'
    'signup': 'signup'

  login: ->
    @app.mainRegion.show new Dashous.Views.Authentication.Login()

  signup: ->
    @app.mainRegion.show new Dashous.Views.Authentication.Signup()
