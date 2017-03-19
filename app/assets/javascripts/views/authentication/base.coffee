class Dashous.Views.Authentication.Base extends Marionette.ItemView

  events:
    'submit @ui.form': 'submitForm'

  enableSubmit: ->
    @ui.submitButton.prop 'disabled', false

  disableSubmit: ->
    @ui.submitButton.prop 'disabled', true
