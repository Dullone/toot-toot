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
    begin
      @user = User.friendly.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render file: 'public/404.html', status: :not_found
      return
    end
    @toots = @user.feed
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

  def newToots
    @user = User.first
    @toot = @user.toots.first

    respond_to do |format|
      format.html { render partial: "toot", locals: { user: @user, toot: @toot }  }
    end
  end

end
