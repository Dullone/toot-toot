class TootsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :feed]
  
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

  def feed
    @toots = current_user.feed
    setLastFeedUpdate
  end

  def newFeedToots
    setLastFeedUpdate

    @toot = @user.toots.first

    respond_to do |format|
      respond = [(render_to_string partial: "toots/toot", locals: { user: @user, toot: @toot })]
      format.json { render json: respond }
    end
  end

  protected
    def setLastFeedUpdate(time = Time.now)
      user_session = session[current_user.id] || { last_feed_update: Time.now }
      user_session[:last_feed_update] = time
    end

end
