class SearchController < ApplicationController
  
  def search
    @users = User.where("username LIKE ?", "#{params[:username]}%").limit(20)
  end

end
