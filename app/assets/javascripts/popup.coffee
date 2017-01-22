window.openPopup = (element) ->
  clearPopupContent()
  paragraphs = getContentParagraphs(element)
  writePopupContent(paragraphs)
  $('.popup').addClass 'open'

window.closePopup = ->
  $('.popup').removeClass 'open'

clearPopupContent = ->
  $('.popup .popup-content').text('')

getContentParagraphs = (element) ->
  $element = $(element)
  content = $element.prop('title')
  content.split "\n"

writePopupContent = (paragraphs) ->
  $.each paragraphs, (index, text) ->
    $('<p/>', {text: text}).appendTo('.popup .popup-content')
