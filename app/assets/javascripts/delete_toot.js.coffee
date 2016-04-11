toot_pending_delete = null

init = () ->
  $("a.delete-toot").on("click", confirmDelete)

confirmDelete = (e) ->
  console.log(e)
  e.preventDefault()
  toot_pending_delete = $(this).closest("div.toot-container")
  toot_text = toot_pending_delete.find("div.toot-text").text()

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
  console.log(path)
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
  console.log("delete complete")
  toot_pending_delete.remove()
  toot_pending_delete = null

delete_error = (e) ->
  console.log("delete error")
  console.log(e)

$(document).on "page:change", -> 
  $(".toots-container").ready(init)