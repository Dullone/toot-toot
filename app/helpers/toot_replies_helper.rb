module TootRepliesHelper
  
  def toot_has_reply?(toot)
    if toot.replies.length > 0
      return true
    end
    false
  end

  def toot_is_reply?(toot)
    TootReply.toot_is_reply?(toot.id)
  end

  def original_toot(toot)
    reply = TootReply.where("reply_toot_id = ?", toot.id)
    original = nil
    if reply.length > 0
      original =  Toot.find(reply.first.toot_id)
    end

    original
  end

end
