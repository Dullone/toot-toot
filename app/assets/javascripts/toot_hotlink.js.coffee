init = () ->
  $("#toots-container").on("click", ".toot-text", showTootPage)

showTootPage = (e) ->
  #if clicked on this element or its parent
  if e.target.nodeName != "A"
    window.location.assign($(this).closest(".toot-container").data('toot-link'));

$(document).on "page:change", -> 
  $(".toots-container").ready(init)