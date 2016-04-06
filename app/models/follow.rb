class Follow < ActiveRecord::Base
  #validations
  validates :followed_id, presence: true
  validates :follower_id, presence: true

  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  #returns empty array if not following, follow array otherwise
  def self.isUserFollowingUser(idHash) 
    Follow.where("follower_id = #{idHash[:follower_id]} AND followed_id = #{idHash[:followed_id]}")
  end

  def self.getFollow(idHash)
    isUserFollowingUser(idHash).first
  end

  def self.isUserFollowingUser?(idHash)
    isUserFollowingUser(idHash).length > 0
  end
end
