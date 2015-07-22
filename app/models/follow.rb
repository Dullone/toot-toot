class Follow < ActiveRecord::Base
  #validations
  validates :followed_id, presence: true
  validates :follower_id, presence: true

  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
end
