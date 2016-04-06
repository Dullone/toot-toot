class RetootsController < ApplicationController
  before_action :authenticate_user!

  def create
    respond_to do |format|
      unless user_signed_in?
        format.json { render json: { message: "login required", status: 401  } }
      else
      
        #begin
          toot = Toot.find(params[:toot_id].to_i)
        #rescue ActiveRecord::RecordNotFound
        #  format.json { render json: { message: "not found"  } }
        #end

        unless toot.user.id == current_user.id #user can't retoot own toot
          retoot = current_user.retoots.new(toot: toot)
      
          if toot && retoot.save
            format.json { render json: { message: "saved"  } }
          else
            format.json { render json: { message: "retoot save failed"  } }
          end

        else
          format.json { render json: { message: "Cannot retoot own toot"  } }
        end
      end
    end
  end

end
