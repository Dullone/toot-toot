class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    begin #catch error if bad data is sent, and username does not exist
      followed = User.find(username: params[:username])
    rescue ActiveRecord::RecordNotFound
      #TODO respond to user not found with error to user
      flash[:notice] = "User not found"
      redirect_to user_toots_path
      return
    end
    follow.new(follower: current_user, followed: followed)
    # if failed to save for some reason - already exist, database error
    if follow.save
      redirect_to user_toots_path
      flash[:notice] = "User succesfully followed"
    else
      render text: "Follow not saved"
    end
  end

end