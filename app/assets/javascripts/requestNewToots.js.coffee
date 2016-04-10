#gets new toots
requestUrl = "/users/newFeedToots"
$tootsContainer = null
newToots        = 0
updateRequestTimer = null
requestInterval = 2000 #2 seconds
requestIntervalLong = 30000 #1/2 minute

init = () ->
  $tootsContainer = $('#toots-container')
  updateRequestTimer = setTimeout(getNewToots, requestInterval)
  console.log("requestin new toots")
  console.log(updateRequestTimer)

getNewToots = () ->
  requestNewToots()
  updateRequestTimer = setTimeout(getNewToots, requestIntervalLong)

clearUpdateQueue = () ->
  clearTimeout(updateRequestTimer)

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
  clearUpdateQueue()
  $(".toots.feed").ready(init)
