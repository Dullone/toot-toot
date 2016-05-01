module TootRepliesHelper
  
  def toot_has_reply?(toot)
    if toot.replies.length > 0
      return true
    end
    false
  end

  def toot_is_reply?(toot)
    if TootReply.where("reply_toot_id = ?", toot.id).length > 0
      return true
    end
    false
  end

end
