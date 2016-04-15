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

  def edit
    @user = current_user
  end

  def update
    user = User.friendly.find(params[:id])

    if current_user.id == user.id
      user.update(user_params)
    end

    redirect_to  user
  end

  private
    def user_params
      params.require(:user).permit(:name, :bio, :location, :website)
    end

end
