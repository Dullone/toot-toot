$retoot_container = null
$clicked_toot = null

init = (retoot_container) ->
  $retoot_container = $(retoot_container)
  $retoot_container.click(retoot)

retoot = (event_data) ->
  $clicked_toot = $(this)
  toot_id = $clicked_toot.data("tootid")
  send_retoot_request(toot_id)

send_retoot_request = (toot_id) ->
  request =
    url: "retoots"
    type: "POST"
    data: 
      toot_id: toot_id
    dataType: "json"
    success:  retoot_complete
    error:    retoot_error

  $.ajax(request)

retoot_complete = (response) ->
  #change retoot link color
  console.log("retoot complete")
  console.log(response)
  if response.message == window.login_required
    window.toot_toot_login()
  if response.message == "saved"
    $clicked_toot.text("↻")

retoot_error = (response) ->
  console.log("retoot error")
  console.log(response)
  if response == window.login_required
    console.log(window.login_required)
    console.log("errors")


$(document).on "page:change", -> 
  init(".toots-container .retoot-toot")