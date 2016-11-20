$ ->

  $search = $('.search input[name="query"]')
  $geolocateButton = $('.search .js-geolocate')

  getGeolocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition showPosition

  showPosition = (position) ->
    location = "#{position.coords.latitude} #{position.coords.longitude}"
    $search.val location

  $geolocateButton.on 'click', ->
    $search.val 'Locating...'
    getGeolocation()

