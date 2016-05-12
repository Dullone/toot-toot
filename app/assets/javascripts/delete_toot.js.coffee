toot_pending_delete = null

init = () ->
  $("#toots-container").on("click", "a.delete-toot", confirmDelete)

confirmDelete = (e) ->
  e.preventDefault()
  toot_pending_delete = $(this).closest("div.toot-container")
  toot_text = toot_pending_delete.find("div.toot-text").first().text()

  swal {
      title: "Delete toot?"
      text: "<div class='border-topbottom'>" + toot_text + "</div>"
      type: "warning"
      showCancelButton: true
      confirmButtonColor: "#DD6B55"
      confirmButtonText: "Yes, delete it!"
      closeOnConfirm: true
      html: true
    }, (isConfirm) ->
      if isConfirm
        deleteToot(e.target.href)

deleteToot = (path) ->
  sendDeleteRequest(path)

sendDeleteRequest = (path) ->
  request =
    url: path
    type: "DELETE"
    dataType: "json"
    success:  delete_complete
    error:    delete_error

  $.ajax(request)

delete_complete = () ->
  toot_pending_delete.remove()
  toot_pending_delete = null

delete_error = (e) ->
  console.log("delete error")

$(document).on "page:change", -> 
  $(".toots-container").ready(init)