module RetootsHelper
  def hasCurrentUserRetooted?(toot_id)
    toots = current_user.retoots.where("toot_id = #{toot_id}")
    toots.length > 0
  end
end
