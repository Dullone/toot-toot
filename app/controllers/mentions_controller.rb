class MentionsController < ApplicationController
  def index
    unless User.friendly.exists_by_friendly_id?(params[:user_id])
      render file: 'public/404.html', status: :not_found
      return
    end

    @user = User.friendly.find_by_friendly_id(params[:user_id])
    if @user
      @mentions = @user.mentions.select(:toot_id).limit(20)
      @toots = Toot.where("id IN (?)", @mentions)
    end
  end
end
