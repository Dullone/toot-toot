init = () ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_posts_url = $('.pagination a.next_page').attr('href')
      if more_posts_url && ($(window).scrollTop() > $(document).height() - $(window).height() - 60)
        console.log("Get more posts")
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_posts_url
    return


$(document).on "page:change", -> 
  $("#infinite-scrolling").ready(init)