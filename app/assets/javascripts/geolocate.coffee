window.getGeolocation = ->
  $search = $('.search input[name="query"]')
  $search.val 'Locating...'
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition showPosition

window.showPosition = (position) ->
  $search = $('.search input[name="query"]')
  location = "#{position.coords.latitude} #{position.coords.longitude}"
  $search.val location

