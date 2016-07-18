$retoot_container = null
$clicked_toot = null

init = (toots_container, retoot_container) ->
  $(toots_container).on("click", retoot_container, retoot)

retoot = (event_data) ->
  $clicked_toot = $(this)
  toot_id = $clicked_toot.data("tootid")
  send_retoot_request(toot_id)

send_retoot_request = (toot_id) ->
  request =
    url: window.retoot_url
    type: "POST"
    data: 
      toot_id: toot_id
    dataType: "json"
    success:  retoot_complete
    error:    retoot_error

  $.ajax(request)

retoot_complete = (response) ->
  #change retoot link color
  if response.message == "saved"
    $clicked_toot.replaceWith("↻")

retoot_error = (response) ->
  if response == window.login_required || response.status == 401
    console.log(window.login_required)
    window.toot_toot_login()


$(document).on "page:change", -> 
  init(".toots-container", ".retoot-toot")