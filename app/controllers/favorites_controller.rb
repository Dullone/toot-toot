class FavoritesController < ApplicationController
  def index
    #check if exsist first, find_by_friendly_id throws exception if not found
    if User.friendly.exists_by_friendly_id?(params[:user_id])
      user = User.friendly.find_by_friendly_id(params[:user_id])
      @toots = user.favorite_toots
    else
      render file: 'public/404.html', status: :not_found
    end
  end
end
