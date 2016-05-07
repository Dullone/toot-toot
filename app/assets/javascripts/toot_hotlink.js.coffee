init = () ->
  console.log ("hotlink init")
  $("#toots-container").on("click", ".toot-container", showTootPage)

showTootPage = (e) ->
  #if clicked on this element or its parent
  if e.target.nodeName != "A"
    window.location.assign($(this).data('toot-link'));

  console.log(e.target.nodeName)

$(document).on "page:change", -> 
  $(".toots-container").ready(init)