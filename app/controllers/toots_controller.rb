class TootsController < ApplicationController
  
  def show
    @user = User.friendly.find(params[:user_id])
    @toot = Toot.find(params[:id])
    
    if @toot.user != @user
      #TODO render error
      render text: "Toot error"
    end
  end

end
