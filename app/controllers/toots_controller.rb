class TootsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def show
    @user = User.friendly.find(params[:user_id])
    @toot = Toot.find(params[:id])
    
    if @toot.user != @user
      #TODO render error
      render text: "Toot error"
    end
  end

  def index
    @user = User.friendly.find(params[:user_id])
    @toots = @user.toots
  end

  def create
    @toot = current_user.toots.new(message: params[:toot][:message])
    if @toot.save
      #saved
      redirect_to user_toots_path
    else
      #error
    end
  end

end
