#colapse expand div if "monitor" element loses focus and is empty
#expand div should default to expanded in the case javascript is disabled

init = (showHidePairs) ->

  for idx, divPair of showHidePairs
    #check if these elements were found on the page
    if divPair["colapse"].length and divPair["expand"].length and 
                                     divPair["monitor"].length
      divPair["colapse"].click(divPair, expandDiv)
      divPair["monitor"].on "focusout", divPair, colapseIfEmpty
      colapseIfEmpty({ data: divPair })

expandDiv = (eventData) -> 
  eventData.data["colapse"].hide()
  eventData.data["expand"].show()
  eventData.data["monitor"].focus()

colapseIfEmpty = (eventData) ->
  unless $.trim(eventData.data["monitor"].val())
    eventData.data["colapse"].show()
    eventData.data["expand"].hide()

$(document).on "page:change", -> 
  init(
      0:
        colapse: $('#new-toot-colapse'),
        expand: $('#toot-form'),
        monitor: $('#toot_message')
  )
