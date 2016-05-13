$toot_form = null
submitPending = false

init = () ->
  $toot_form = $("#new_toot")
  $toot_form.on("ajax:success",   tootSumbitSuccess)
  $toot_form.on("ajax:error",     tootSumbitError)
  $toot_form.on("ajax:complete",  onSumbitComplete)
  $toot_form.on("submit",         onSumbit)
  $toot_form.on("keypress",       onKeyPress)


onKeyPress = (e) ->
  enterSubmit(e)
  if checkIfValidToot
    clearError()

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
  clearError()

tootSumbitError = (e, data, status, xhr) ->
  setError('error submitting toot')

clearError = () ->
  $toot_form.find('.warning').text('')

setError = (errorText) ->
  $toot_form.find('.warning').text(errorText)

onSumbit = (e) ->
  unless checkIfValidToot()
    e.preventDefault()
    return false
  disableForm(true)
  submitPending = true
  showWaitingDiv(true)

onSumbitComplete = () ->
  disableForm(false)
  submitPending = false
  showWaitingDiv(false)

checkIfValidToot = () ->
  if $toot_form.find("textarea").val().length < 2
    setError("Toot too short")
    return false

  return true

disableForm = (disable) ->
  if disable
    $("#new_toot :submit").attr("disabled", true)
    $toot_form.find("textarea").blur()
    #$toot_form.find("textarea").attr("disabled", true)
  else
    $("#new_toot :submit").attr("disabled", false)
    #$toot_form.find("textarea").attr("disabled", false)

showWaitingDiv = (show) ->
  if show
    visibility = 'visible'
  else
    visibility = 'hidden'

  $toot_form.find('#waitingCircleG').css('visibility', visibility);

$(document).on "page:change", -> 
  $("#new_toot").ready(init)
