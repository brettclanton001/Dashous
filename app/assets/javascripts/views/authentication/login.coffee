class Dashous.Views.Authentication.Login extends Marionette.ItemView
  template: 'authentication/login'

  templateHelpers: ->
    formToken: Dashous.formToken
