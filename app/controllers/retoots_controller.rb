class RetootsController < ApplicationController
  before_action :authenticate_user!

  def create
    message = ""
    status = 400
    retoot_link = ""
    
    unless user_signed_in?
      message = "login required"
      status = 401
    else
    
      toot = Toot.find(params[:toot_id].to_i)

      unless toot.user.id == current_user.id #user can't retoot own toot
        retoot = current_user.retoots.new(toot: toot)
    
        if toot && retoot.save
            message = "saved"
            retoot_link = render_to_string( partial: "/toots/retoot_delete_link", locals: { toot: toot } )
        else
          message = "retoot save failed" 
        end

      else
        message = "Cannot retoot own toot"
      end
    end

    respond_to do |format|
      format.json { render json: { message: message, status: status, retoot_link: retoot_link } }
    end

  end

  def destroy
    retoot = Retoot.where(toot_id: params[:id], user_id: current_user.id).first
    
    message = "failed"
    success = false
    retoot_link = ""

    if retoot  && (retoot.user == current_user)
      retoot_link =  render_to_string( partial: "/toots/retoot_link", locals: { toot: retoot.toot } )
      retoot.destroy
      message = "deleted"
      success = true
    else
      message = "no a user owned retoot"
    end

    respond_to do |format|
      format.json { render json: { message:  message, success: success, retoot_link: retoot_link }  }
    end
  end

end
