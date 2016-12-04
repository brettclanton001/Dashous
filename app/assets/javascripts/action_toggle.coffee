window.onClickActionToggle = (element) ->
  $element = $(element)
  $container = $element.parent('.actions')
  $('.actions').removeClass('open') unless $container.hasClass('open')
  $container.toggleClass 'open'
