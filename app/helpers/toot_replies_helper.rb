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

end
