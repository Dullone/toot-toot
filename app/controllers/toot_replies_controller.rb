class TootRepliesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  include TootCreation

  def create
    replyToot = create_toot(params[:toot][:message], current_user)
    orignal_toot = Toot.find_by_id(params[:toot_id])

    response = { }
    if orignal_toot 
        TootReply.create(toot: orignal_toot, reply_toot: replyToot)
        response[:success] =  true
      else
        response[:success] =  false
      end
    respond_to do |format|
      format.json { render json: response }
    end
  end

  def requestReply
    @toot = Toot.find_by_id(params[:toot_id])

    response = {}

    respond_to do |format|
      if @toot
        response[:replyForm] = render_to_string partial: "/toots/toot_reply_form", 
                                                      locals: { toot: @toot }
        response[:isReplyOk] = true
      else
        response[:isReplyOk] = false
        response[:errorReason] = "Toot not found"
      end

      format.json { render json: response }
    end
  end

end
