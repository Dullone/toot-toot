username_box    = 'user_username'
$username_box   = null
checkDelay      = null

availibility      = 'username-available'
$availibility     = null
availibilityClass =
  true:   "ok"
  false:  "error"

checkError = "error checking"

init = () ->
  $username_box = $('#' + username_box)

  console.log("Available start")

  #$username_box.change(onUsernameChanged)
  $username_box.on('input',onUsernameChanged)
  $availibility = $('#' + availibility)


onUsernameChanged = (event) ->
  if checkDelay
    clearTimeout(checkDelay)
  #wait half a second before checking
  checkDelay = setTimeout(checkUsernameAvailibity, 500, $username_box.val())

checkUsernameAvailibity = (username) ->
  console.log(username)
  if username.length < 3
    showAvailibility({message: "too short", available: false})
    return
  request =
    url: "usernameAvailable"
    data: 
      username: username
    dataType: "json"
    success:    showAvailibility
    error:      errorCheckingAvalibility
    beforeSend: ajaxWaiting

  $.ajax(request)

showAvailibility = (response) ->
  removeClasses()
  $availibility.text(response.message)
  $availibility.addClass(availibilityClass[response.available])

removeClasses = () ->
  remove = for val, aClass of availibilityClass
    $availibility.removeClass(aClass)


errorCheckingAvalibility = () ->
  $availibility.text(checkError)
  $availibility.addClass(availibilityClass[false])

ajaxWaiting = () ->
  removeClasses()
  $availibility.text("checking...")

$(document).on "page:change", -> 
  $(".registrations.new").ready(init)