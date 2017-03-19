class Dashous.Views.Authentication.Login extends Dashous.Views.Authentication.Base
  template: 'authentication/login'

  ui:
    form: '.js-form'
    inputs: '.js-form input'
    submitButton: '.js-form input[type="submit"]'
    errorMessage: '.js-error-message'
    username: '.js-form input#user_username'
    password: '.js-form input#user_password'

  initialize: ->
    @session = new Backbone.Model
    @session.url = '/api/v1/authentication/sessions'

  ##################################################################

  submitForm: (e) ->
    e.preventDefault()
    @disableSubmit()
    @session.save
      authenticity_token: Dashous.formToken
      user:
        username: @ui.username.val()
        password: @ui.password.val()
    .fail =>
      @handleFailure()
    .success =>
      @handleSuccess()

  handleSuccess: ->
    window.location.href = '/u/trade_requests'

  handleFailure: ->
    @ui.inputs.addClass 'error'
    @ui.errorMessage.text 'Invalid Username or password.'
    @enableSubmit()

