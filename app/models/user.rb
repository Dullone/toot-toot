class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  before_save :add_at_username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  MAX_USERNAME_LENGTH = 20
  MAX_BIO_LENGHT = 500
  MAX_NAME_LENGTH = 40
  MAX_WEBSITE_LENGTH = 255
  MAX_LOCATION_LENGTH = 255
  MIN_USERNAME_LENGTH = 3
  VALID_USERNAME_CHARACTERS = "[a-zA-Z_0-9]"
  #Validations
  validates :username, length: { minimum: MIN_USERNAME_LENGTH, maximum: MAX_USERNAME_LENGTH },
              uniqueness: true
  validates_format_of :username, :with => /\A#{VALID_USERNAME_CHARACTERS}+\z/,
                      :message => "Only letters, numbers or underscore allowed"

  validates :name, length: { minimum: 2, maximum: MAX_NAME_LENGTH }
  validates :bio, length: { maximum: MAX_BIO_LENGHT }
  validates :website, length: { maximum: MAX_WEBSITE_LENGTH }
  validates :location, length: { maximum: MAX_LOCATION_LENGTH }

  #toots
  has_many :toots
  has_many :retoots, dependent: :destroy
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
  has_many :favorites, dependent: :destroy
  has_many :favorite_toots, through: :favorites, source: :toot
  
  #mentions
  has_many :mentions, dependent: :destroy

  def toots_and_retoots_since(time, limit = 20)
    new_retoots = Retoot.where("user_id IN (?) AND created_at > ?", following_ids, time).select("toot_id").limit(limit)
    (Toot.where("user_id IN (?) AND created_at > ?", following_ids, time).order(created_at: :desc) + 
               Toot.where("id in (?)", new_retoots) + 
               self.toots.where("created_at > ?", time).limit(limit)).uniq
  end

  def feed(page = 1, limit = 20)
    feed_toots = Toot.where("user_id IN (?) OR id IN (?)", 
                            (following_ids << id), 
                            retoot_ids)
                     .order(created_at: :desc)
    feed_toots.paginate(per_page: limit, page: page)
  end

  def getFeedTootsSince(time)
    toots_and_retoots_since(time)
  end

  def isUserFollowing?(user_id)
    Follow.isUserFollowingUser?({ follower_id: self.id, followed_id: user_id })
  end


  def self.ci_find_by_username(username)
    where("lower(username) = ?", username.downcase).first
  end

  def username_and_name
    self.at_username #+ ", " + self.name
  end

  private
    def add_at_username
      self.at_username = "@" + self.username
    end

end
