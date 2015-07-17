username_check  = true
username_box    = 'user_username'
$username_box   = null
checkDelay      = null

availibility      = 'username-available'
$availibility     = null
availibilityClass =
  true:   "ok"
  false:  "error"

init = () ->
  unless username_check
    return

  console.log("inside")

  $username_box = $('#' + username_box)

  checkError = "error checking"

  $username_box.change(onUsernameChanged)
  $availibility = $('#' + availibility)


onUsernameChanged = (event) ->
  console.log("onUserneameChanged")
  if checkDelay
    clearTimeout(checkDelay)
  checkDelay = setTimeout(checkUsernameAvailibity, 500, $username_box.val())

checkUsernameAvailibity = (username) ->
  console.log("CheckAvailable:")
  console.log(username)
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
  console.log(response)
  console.log($availibility)
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
  $availibility.text("checking...")

$(document).on("page:change", init)