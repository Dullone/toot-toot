class FavoritesController < ApplicationController
  def index
    #check if exsist first, find_by_friendly_id throws exception if not found
    if User.friendly.exists_by_friendly_id?(params[:user_id])
      @user = User.friendly.find_by_friendly_id(params[:user_id])
      @toots = @user.favorite_toots.paginate(page: params[:page], per_page: 20).to_a
      respond_to do |format|
        format.html
        format.js
      end
    else
      render file: 'public/404.html', status: :not_found
    end
  end

  def create
    message = "error"
    unfav_url = ""
    toot_id = params[:toot_id]
    if current_user.friendly_id == params[:user_id] && Toot.exists?(toot_id)
      favorite = current_user.favorites.new(toot_id: params[:toot_id])
      if favorite.save()
        message = "saved"
        toot = Toot.find(toot_id);
        fav_link = render_to_string(partial: "/toots/toot_favorite_link", locals: { toot: toot })
      end
    end

    respond_to do |format|
      format.json { render json: { message: message, fav_link: fav_link } }
    end
  end

  def destroy
    favorite = Favorite.find_by_id(params[:id])
    toot = favorite.toot    
    if current_user && current_user.friendly_id == params[:user_id] && favorite
      favorite.destroy()
    end

    fav_link = render_to_string(partial: "/toots/toot_favorite_link", locals: { toot: toot } )

    respond_to do |format|
      format.json { render json: { :message => "deleted", fav_link: fav_link } }
    end

  end
end
