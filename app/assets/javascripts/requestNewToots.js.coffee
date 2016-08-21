#gets new toots
requestUrl = "/users/newFeedToots"
$tootsContainer = null
newToots        = 0
updateRequestTimer = null
intialRequestInterval = 2000 #2 seconds
requestIntervalLong = 30000 #1/2 minute
requestPending = false
is_logged_in = true #assume logged until proven false

init = () ->
  $tootsContainer = $('#toots-container')
  updateRequestTimer = setTimeout(onUpdateInterval, intialRequestInterval)

getNewToots = () ->
  if requestPending
    return
  clearUpdateQueue()
  requestNewToots()
  updateRequestTimer = setTimeout(onUpdateInterval, requestIntervalLong)

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
  #gootle analytics
  ga('send', 
    hitType: 'event',
    eventCategory: 'request',
    eventAction: 'getNewToots',
    eventLabel: 'newFeedToots'
    )

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
      $reply_container = $toot.find(".toot-reply-container")
      if $reply_container.length > 0
        originalTootDiv = findTootDivByID($reply_container.data("original-tootid"))
        console.log($toot)
        $toot.removeClass("row")
        originalTootDiv.append($toot)
      else
        $tootsContainer.prepend($toot)
      $toot.hide().slideDown()

findTootDivByID = (id)->
  selector = '.toot-container[data-tootid="' +  id + '"]'
  return $(selector)

error = (response) ->
  requestPending = false
  console.log("error with request: ")
  console.log(response)

@getNewToots = getNewToots

$(document).on "page:change", -> 
  clearUpdateQueue()
  $("body.feed").ready( ->
    $("#toots-container").ready(init)
  )
