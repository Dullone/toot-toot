#gets new toots
requestUrl = "/users/newFeedToots"
$tootsContainer = null
newToots        = 0
requestInterval = 2000

init = () ->
  $tootsContainer = $('#toots-container')
  setTimeout(requestNewToots, requestInterval)

requestNewToots = () ->
  request =
    url:        requestUrl
    dataType:   "json"
    success:    htmlRecieved
    error:      error

  $.ajax(request)

htmlRecieved = (response) ->
  console.log(response)
  addNewToots(response)

addNewToots = (toots) ->
  for toot in toots
    do(toot) ->
      newToots++
      $toot = $(toot)
      $tootsContainer.prepend($toot)
      $toot.hide().slideDown()

error = (response) ->
  console.log("error")
  console.log(response)
  console.log(response.responseText)


$(document).on "page:change", -> 
  $(".toots.index").ready(init)
