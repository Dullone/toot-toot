#gets new toots
requestUrl = "/users/newToots"
$tootsContainer = nil
newToots        = 0

init = () ->
  $tootsContainer = $('#toots-container')
  setTimeout(requestNewToots)

requestNewToots = () ->
  request =
    url:        requestUrl
    dataType:   "html"
    success:    htmlRecieved
    error:      error

  $.ajax(request)

htmlRecieved = (response) ->
  addNewToots(respons)

addNewToots = (toots) ->
  
  newToots++
  $response = $(response)
  $tootsContainer.prepend($response)
  $response.hide().slideDown()

error = () ->
  console.log("error")

#$(".toots.index").ready(init)
