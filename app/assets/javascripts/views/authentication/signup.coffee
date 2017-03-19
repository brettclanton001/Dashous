class Dashous.Views.Authentication.Signup extends Dashous.Views.Authentication.Base
  template: 'authentication/signup'

  ui:
    form: '.js-form'
    inputs: '.js-form input'
    submitButton: '.js-form input[type="submit"]'
    errorMessages: '.js-form .js-error-message'
    email: '.js-form input#user_email'
    username: '.js-form input#user_username'
    password: '.js-form input#user_password'
    password_confirmation: '.js-form input#user_password_confirmation'
    terms_and_conditions: '.js-form input#user_terms_and_conditions'
    successMessage: '.js-success'

  initialize: ->
    @registration = new Backbone.Model
    @registration.url = '/api/v1/authentication/registrations'

  ##################################################################

  submitForm: (e) ->
    e.preventDefault()
    @disableSubmit()
    @registration.save
      authenticity_token: Dashous.formToken
      user:
        email: @ui.email.val()
        username: @ui.username.val()
        password: @ui.password.val()
        password_confirmation: @ui.password_confirmation.val()
        terms_and_conditions: if @ui.terms_and_conditions.is(':checked') then '1' else '0'
    .fail (data) =>
      @handleFailure(data)
    .success =>
      @handleSuccess()

  handleSuccess: ->
    @ui.form.hide()
    @ui.successMessage.show()

  handleFailure: (data) ->
    @ui.errorMessages.text ''
    @ui.inputs.removeClass 'error'
    $.each data.responseJSON, (field, message) =>
      @ui[field].addClass 'error'
      @ui.form.find(".field[data-field-for='#{field}'] .js-error-message").text message[0]
    @enableSubmit()

