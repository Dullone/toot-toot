class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Validations
  validates :username, length: { minimum: 3, maximum: 20 },
              uniqueness: true
  validates :name, length: { minimum: 2, maximum: 40 }
  validates :bio, length: { maximum: 500 }
  validates :website, length: { maximum: 255 }
  validates :location, length: { maximum: 255 }

  #toots
  has_many :toots
  has_many :retoots
  has_many :retooted, through: :retoots, source: :toot

  #folowing
  has_many :active_follows,  class_name: "Follow", 
                            foreign_key: "follower_id",
                              dependent: :destroy
  has_many :passive_follows, class_name: "Follow",
                            foreign_key: "followed_id",
                              dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  #favorites
  has_many :favorites

  def toots_and_retoots(limit = 20)
    (toots.limit(limit) + retooted.limit(limit))[0...limit]
  end

  def feed(limit = 20)
    user_toots = toots_and_retoots
    following_toots = Toot.where("user_id IN (?)", following_ids)
    (user_toots + following_toots)[0..limit].sort!{ |f, s| s[:created_at] <=> f[:created_at ]}
  end

  def getFeedTootsSince(time)
    user_toots = toots_and_retoots
    new_toots = Toot.where("user_id IN (?) AND created_at > ?", following_ids, time)
  end

  def isUserFollowing?(user_id)
    Follow.isUserFollowingUser?({ follower_id: self.id, followed_id: user_id })
  end

end
