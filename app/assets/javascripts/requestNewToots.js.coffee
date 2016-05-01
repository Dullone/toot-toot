#gets new toots
requestUrl = "/users/newFeedToots"
$tootsContainer = null
newToots        = 0
updateRequestTimer = null
intialRequestInterval = 2000 #2 seconds
requestIntervalLong = 3000000 #1/2 minute
requestPending = false
is_logged_in = true #assume logged until proven false

init = () ->
  $tootsContainer = $('#toots-container')
  updateRequestTimer = setTimeout(onUpdateInterval, intialRequestInterval)

getNewToots = () ->
  clearUpdateQueue()
  requestNewToots()
  updateRequestTimer = setTimeout(onUpdateInterval, requestIntervalLong)
  console.log('get new toots')

onUpdateInterval = () ->
  if is_logged_in
    getNewToots()
  else
    console.log("Not logged in, ceasing updates")


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
  is_logged_in = response.is_logged_in
  addNewToots(response.toots)
  #Register new toots for updating timestamp
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
  console.log("error with request: ")
  console.log(response)

@getNewToots = getNewToots

$(document).on "page:change", -> 
  clearUpdateQueue()
  $("#toots-container").ready(init)
