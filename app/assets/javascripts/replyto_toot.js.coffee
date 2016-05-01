init = () ->
  console.log("replyjs init")
  $("#toots-container").on("click", "a.replyto-toot", replytoToot)

replytoToot = (e) ->
  console.log("reply clicked")
  e.preventDefault()
  requestTootReply(e.target.href, $(e.target).data("tootid"))

requestTootReply = (path, data) ->
  console.log(data)
  request =
    url: "/toot_replies/requestReply"
    dataType: "json"
    data:
      toot_id: data
    success:  showReplyForm
    error:    replyError

  $.ajax(request)

showReplyForm = (response) ->
  console.log(response)
  if response.isReplyOk
    swal {
      title: "Toot reply"
      text: response.replyForm
      showCancelButton: true
      confirmButtonText: "toot"
      closeOnConfirm: false
      html: true
    }, (isConfirm) ->
      if isConfirm
        postReply($("#toot-reply-text").val(), $("#toot-reply-text").closest(".new_toot").attr('action'))

postReply = (text, url) ->
  console.log(text)
  console.log(url)

  request =
    url: url
    type: "POST"
    dataType: "json"
    data:
      toot:
        message: text
    success:  newReplySuccess
    error:    newReplyError

  $.ajax(request)

newReplySuccess = () ->
  swal("Submitted", "tooted!", "success")
  getNewToots()

newReplyError = () ->
  swal("Failure", "error submitting toot", "error")

replyError = (response) ->
  swal {
      title: "Toot error"
      text: "Unknown error"
      showCancelButton: true
      confirmButtonColor: "#DD6B55"
      confirmButtonText: "ok"
      closeOnConfirm: true
      html: true
    }

$(document).on "page:change", -> 
  $(".toots-container").ready(init)