class TootsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :feed, :delete]
  
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
      parsedToot = Toot.parse(@toot.message)

      parsedToot[:mentions].each do |u|
      user = User.ci_find_by_username u
      if user
        @toot.mentions.create user: user
      end
    end
      redirect_to user_toots_path
    else
      #error
    end
  end

  def destroy
    response = ""

    begin
      toot = Toot.find(params[:id])
      
      unless toot.user_id == current_user.id 
        response = { status: "not authorized" }
      else
        toot.destroy
        response = { status: "success" }
      end
    rescue
      response = { status: "not found"}
    end

    respond_to do |format|
      format.json { render json: response }
    end
  end


  def feed
    @toots = current_user.feed
    @user = current_user
    setLastFeedUpdate
  end

  def newFeedToots
    new_toots = current_user.getFeedTootsSince(getLastFeedUpdate)
    setLastFeedUpdate

    response = []

    respond_to do |format|
      new_toots.each do |toot|
          #us unshift so when we unwind the array on the client, its in the correct order
          response.unshift(render_to_string partial: "toots/toot", locals: { user: toot.user, toot: toot })
      end
      format.json { render json: response }
    end
  end

  protected
    def setLastFeedUpdate(time = Time.now.utc)
      session[:last_feed_update] = time
    end

    def getLastFeedUpdate
      session[:last_feed_update]
    end

end
