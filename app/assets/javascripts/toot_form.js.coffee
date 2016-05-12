$toot_form = null
submitPending = false

init = () ->
  $toot_form = $("#new_toot")
  $toot_form.on("ajax:success",   tootSumbitSuccess)
  $toot_form.on("ajax:error",     tootSumbitError)
  $toot_form.on("ajax:complete",  onSumbitComplete)
  $toot_form.on("submit",         onSumbit)
  $toot_form.on("keypress",       enterSubmit)


enterSubmit = (e) ->
  #check if enter was pressed, submit form if it was
  if submitPending
    return
  if e.which && e.which == 13 || e.keyCode && e.keyCode == 13
    $toot_form.submit()
    e.preventDefault()

tootSumbitSuccess = (e, data, status, xhr) ->
  getNewToots()
  $toot_form.find("input[type=text], textarea").val("")
  $toot_form.find("textarea").blur()

tootSumbitError = (e, data, status, xhr) ->
  console.log("error submitting toot")

onSumbit = (e) ->
  $("#new_toot :submit").attr("disabled", true)
  submitPending = true

onSumbitComplete = () ->
  $("#new_toot :submit").attr("disabled", false)
  submitPending = false

$(document).on "page:change", -> 
  $("#new_toot").ready(init)
