Backbone.Marionette.Renderer.render = (template, data) ->
  unless HandlebarsTemplates[template]
    throw "Template '#{template}' not found."
  HandlebarsTemplates[template](data)
