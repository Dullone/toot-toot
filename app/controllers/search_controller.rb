class SearchController < ApplicationController
  
  def search
    @users = User.where("username LIKE ?", params[:username])
  end

end
