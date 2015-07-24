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
end
