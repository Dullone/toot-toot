init = (showHidePairs) ->

  for idx, divPair of showHidePairs
    #check if these elements were found on the page
    #if divPair["colapse"].leghth and divPair["expand"].length and 
     #                                    divPair["monitor"].length
      divPair["colapse"].click(divPair, expandDiv)
      divPair["monitor"].on "focusout", divPair, colapseIfEmpty
      console.log("Call colapse")
      colapseIfEmpty({ data: divPair })

expandDiv = (eventData) -> 
  console.log("expanding")
  eventData.data["colapse"].hide()
  eventData.data["expand"].show()
  eventData.data["monitor"].focus()

colapseIfEmpty = (eventData) ->
  console.log(eventData.data)
  unless $.trim(eventData.data["monitor"].val())
    console.log("colpasing")
    eventData.data["colapse"].show()
    eventData.data["expand"].hide()

$(document).on "page:change", -> 
  init(
      0:
        colapse: $('#new-toot-colapse'),
        expand: $('#toot-form'),
        monitor: $('#toot-form textarea')
  )
