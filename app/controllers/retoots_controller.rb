class RetootsController < ApplicationController
  before_action :authenticate_user!

  def create
    respond_to do |format|
      
      #begin
        toot = Toot.find(params[:toot_id].to_i)
      #rescue ActiveRecord::RecordNotFound
      #  format.json { render json: { success: "not found"  } }
      #end

      unless toot.user == current_user #user can't retoot own toot
        retoot = current_user.retoots.new(toot: toot)
    
        if toot && retoot.save
          format.json { render json: { success: "saved"  } }
        else
          format.json { render json: { success: "retoot save failed"  } }
        end

      else
        format.json { render json: { success: "login required"  } }
      end
    end
  end

end
