$toot_form = null

init = () ->
  $toot_form = $("#new_toot")
  $toot_form.on("ajax:success", tootSumbitSuccess)
  $toot_form.on("ajax:error",   tootSumbitError)
  $toot_form.on("ajax:complete", onSumbitComplete)
  $toot_form.on("ajax:start", onSumbit)


tootSumbitSuccess = (e, data, status, xhr) ->
  getNewToots()
  $toot_form.find("input[type=text], textarea").val("")
  $toot_form.find("textarea").blur()

tootSumbitError = (e, data, status, xhr) ->
  console.log("error submitting toot")
  console.log("stuats")

onSumbit = () ->
  console.log("submit clicked")
  $("#new_toot :submit").attr("disabled", true)

onSumbitComplete = () ->
  $("#new_toot :submit").attr("disabled", false)

$(document).on "page:change", -> 
  $("#new_toot").ready(init)
