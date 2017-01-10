class StaticPagesController < ApplicationController
  def help
  end

  def homepage
    if current_user
      redirect_to toots_feed_url
    else
      example_user = User.find_by_username "Ruby"
      if example_user
        redirect_to user_toots_url(example_user)
      else
        redirect_to users_url
      end
    end
  end
end
