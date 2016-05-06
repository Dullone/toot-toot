init = () ->
  console.log ("hotlink init")
  $("#toots-container").on("click", ".toot-container", showTootPage)

showTootPage = (e) ->
  #if clicked on this element or its parent
  if e.target == this || $(e.target).parent()[0] == this
    window.location.assign($(this).data('toot-link'));

$(document).on "page:change", -> 
  $(".toots-container").ready(init)