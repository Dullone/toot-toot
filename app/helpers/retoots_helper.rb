module RetootsHelper
  def hasCurrentUserRetooted?(toot_id)
    unless user_signed_in?
      return false
    end
    toots = current_user.retoots.where("toot_id = #{toot_id}")
    toots.length > 0
  end
end
