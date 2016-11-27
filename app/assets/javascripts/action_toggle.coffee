window.onClickActionToggle = (element) ->
  $element = $(element)
  $container = $element.parent('.actions')
  $container.toggleClass 'open'
