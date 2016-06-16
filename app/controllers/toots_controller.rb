class TootsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :feed, :delete]
  include TootsHelper

  def show
    @user = User.friendly.find(params[:user_id])
    @toot = Toot.find(params[:id])
    
    if @toot.user != @user
    #TODO render error
      render text: "Toot error"
    end
  end

  def index
    toots_per_page = 20
    begin
      @user = User.friendly.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render file: 'public/404.html', status: :not_found
      return
    end
    @toots = @user.toots.paginate(page: params[:page], per_page: toots_per_page).to_a
  end

  def create
    message = params[:toot][:message]
    if params[:toot][:message].is_a?(Array)
      message =  message.first
    end

    if create_toot(message, current_user)
      puts "Toot create success"
    else
      puts "toot create failure"
    end
      
    redirect_to user_toots_path
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
    toots_per_page = 20
    @toots = current_user.feed(params[:page], toots_per_page).to_a
    @user = current_user
    setLastFeedUpdate
  end

  def newFeedToots
    response = {}
    response[:toots] = []
    response[:is_logged_in] = true

    unless user_signed_in?
      response[:is_logged_in] = false
      respond_to do |format|
        format.json { render json: response }
      end

      return
    end

    new_toots = current_user.getFeedTootsSince(getLastFeedUpdate)
    setLastFeedUpdate

    respond_to do |format|
      new_toots.each do |toot|
          #us unshift so when we unwind the array on the client, its in the correct order
          response[:toots].unshift(render_to_string partial: "toots/toot", locals: { 
                      toot: toot,  options: { show_replies: false, 
                        no_row: true,
                                              render_replies_as_single: true}})
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
