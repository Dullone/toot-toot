module RetootsHelper
  def hasCurrentUserRetooted?(toot_id)
    unless user_signed_in?
      return false
    end
    toots = current_user.retoots.where("toot_id = #{toot_id}")
    toots.length > 0
  end

  def isValidRetoot?(toot_id)
    !hasCurrentUserRetooted?(toot_id) && current_user.toots.where("id = #{toot_id}").length == 0
  end
end
