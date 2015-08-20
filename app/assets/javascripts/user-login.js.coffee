toot_toot_login = (current_url, redirect_url, options) ->
  window.location.replace(window.login_url);

$ ->
  console.log(login_url)
  return toot_toot_login