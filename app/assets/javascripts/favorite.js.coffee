$favorite_container = null
$clicked_toot = null
request_pending = false

init = (toots_container, favorite_container) ->
  $(toots_container).on("click", favorite_container, favorite)

favorite = (event_data) ->
  if request_pending
    return
  request_pending = true

  $clicked_toot = $(this)
  toot_id = $clicked_toot.data("tootid")

  request_type = "POST"
  url = $clicked_toot.data("fav-url")
  if $clicked_toot.data("favorite")
    request_type = "DELETE"
    url = $clicked_toot.data("unfav-url")

  send_favorite_request(toot_id, request_type, url)


send_favorite_request = (toot_id, request_type, url) ->
  console.log(url)
  request =
    url: url
    type: request_type
    data:
      toot_id: toot_id
    dataType: "json"
    success:  favorite_complete
    error:    favorite_error

  $.ajax(request)

favorite_complete = (response) ->
  #change retoot link color
  if response.message == "saved"
    $clicked_toot.data("unfav-url", response.unfav_url)
    changeTootToFavorite($clicked_toot)
  else if response.message == "deleted"
    changeTootToNotFavorite($clicked_toot)
  else
    console.log(response.message)

  request_pending = false

changeTootToFavorite = ($toot) ->
  console.log("displayTootAsFavorite")
  console.log($toot)
  $toot.text("unfav")
  $toot.data("favorite", true)

changeTootToNotFavorite = ($toot) ->
  console.log("displayTootAsNotFavorite")
  console.log ($toot)
  $toot.text("fav")
  $toot.data("favorite", false)

favorite_error = (response) ->
  request_pending = false

$(document).on "page:change", -> 
  init(".toots-container", ".favorite-toot")