class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :delete]

  def create
    begin #catch error if bad data is sent, and username does not exist
      followed = User.find(params[:following_id])
    rescue ActiveRecord::RecordNotFound
      #TODO respond to user not found with error to user
      flash[:notice] = "User not found"
      redirect_to toots_feed_path
      return
    end
    follow = Follow.new(follower_id: current_user.id, followed_id: followed.id)
    # if failed to save for some reason - already exist, database error
    if follow.save
      redirect_to toots_feed_path
      flash[:notice] = followed.username + " succesfully followed"
    else
      render text: "Follow not saved"
    end
  end

  def destroy
    begin 
      follow = Follow.find(params[:id])
      unfollowed_user = User.find(follow.followed_id)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Follow or user not found"
      redirect_to toots_feed_path
    end

    if follow.follower_id == current_user.id
      flash[:notice] = "Unfollowed " + unfollowed_user.username
      follow.destroy
    else
      flash[:notice] = "Not following "
    end

    redirect_to toots_feed_path
  end

  def following
    unless User.friendly.exists_by_friendly_id?(params[:user_id])
      page_not_found
      return
    end

    @user = User.friendly.find_by_friendly_id(params[:user_id])
    if @user
      @users = @user.following.limit(20)
    end
  end

  def followers
    unless User.friendly.exists_by_friendly_id?(params[:user_id])
      page_not_found
      return
    end

    @user = User.friendly.find_by_friendly_id(params[:user_id])
    if @user
      @users = @user.followers.limit(20)
    end
  end

end
