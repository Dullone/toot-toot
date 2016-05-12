init = () ->
  $("#toots-container").on("click", "a.replyto-toot", replytoToot)

replytoToot = (e) ->
  e.preventDefault()
  requestTootReply(e.target.href, $(e.target).data("tootid"))

enterSubmit = (e) ->
  console.log("enterSubmit reply")
  if e.which && e.which == 13 || e.keyCode && e.keyCode == 13
    e.preventDefault()
    sweeAlertConfirm()

sweeAlertConfirm = () ->
  $(".sweet-alert").find("button.confirm")[0].click()
  console.log("sa confirm")

requestTootReply = (path, data) ->
  request =
    url: "/toot_replies/requestReply"
    dataType: "json"
    data:
      toot_id: data
    success:  showReplyForm
    error:    replyError

  $.ajax(request)

showReplyForm = (response) ->
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
        postReply($('#toot-reply-text').val(), $('#toot-reply-text').closest(".new_toot").attr('action'))

    $('#toot-reply-text').railsAutocomplete()
    setFocusAndMoveCursorToEnd($('#toot-reply-text'))
    $('.new_toot').on("keypress", enterSubmit)

setFocusAndMoveCursorToEnd = ($element) ->
    $element.focus()
    len = $element.val().length * 2
    $element[0].setSelectionRange(len, len)

postReply = (text, url) ->
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