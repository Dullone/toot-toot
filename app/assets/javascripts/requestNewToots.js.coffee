#gets new toots
requestUrl = "/users/newFeedToots"
$tootsContainer = null
newToots        = 0
updateRequestTimer = null
requestInterval = 2000 #2 seconds
requestIntervalLong = 30000 #1/2 minute
requestPending = false

init = () ->
  $tootsContainer = $('#toots-container')
  updateRequestTimer = setTimeout(getNewToots, requestInterval)

getNewToots = () ->
  clearUpdateQueue()
  requestNewToots()
  updateRequestTimer = setTimeout(getNewToots, requestIntervalLong)
  console.log('get new toots')

clearUpdateQueue = () ->
  clearTimeout(updateRequestTimer)

requestNewToots = () ->
  request =
    url:        requestUrl
    dataType:   "json"
    success:    htmlRecieved
    error:      error

  requestPending = true
  $.ajax(request)

htmlRecieved = (response) ->
  requestPending = false
  addNewToots(response)
  $("time.timeago").timeago()

addNewToots = (toots) ->
  for toot in toots
    do(toot) ->
      newToots++
      $toot = $(toot)
      $tootsContainer.prepend($toot)
      $toot.hide().slideDown()

error = (response) ->
  requestPending = false
  console.log("error with request")

@getNewToots = getNewToots

$(document).on "page:change", -> 
  clearUpdateQueue()
  $("#toots-container").ready(init)
