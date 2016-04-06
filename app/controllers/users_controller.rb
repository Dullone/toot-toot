class UsersController < ApplicationController
  
  def usernameAvailable
    username    = User.where(username: params[:username])
    message     = ""
    available   = false

    if username.length > 0
      message   = "unavailable"
    else
      message   = "available"
      available = true
    end

    respond_to do |format|
      format.json { render json: { message: message, available: available } }
    end
  end

  def index
    @users = User.all
  end

end
