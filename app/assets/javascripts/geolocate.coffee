$ ->

  getGeolocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition showPosition

  showPosition = (position) ->
    location = "#{position.coords.latitude} #{position.coords.longitude}"
    $('.search input[name="query"]').val location

  getGeolocation()

