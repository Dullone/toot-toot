class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, length: { minimum: 3, maximum: 20 },
              uniqueness: true
  validates :name, length: { minimum: 2, maximum: 40 }
  validates :bio, length: { maximum: 500 }
  validates :website, length: { maximum: 255 }
  validates :location, length: { maximum: 255 }

  has_many :toots
end
