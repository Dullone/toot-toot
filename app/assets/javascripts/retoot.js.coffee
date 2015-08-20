$retoot_container = null

init = (retoot_container) ->
  $retoot_container = $(retoot_container)
  $retoot_container.click(retoot)

retoot = (event_data) ->
  toot_id = $(this).data("tootid")
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

retoot_error = (response) ->
  console.log("retoot error")
  console.log(response)

$(document).on "page:change", -> 
  init(".toots-container .retoot-toot")