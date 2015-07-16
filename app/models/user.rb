class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: { minimum: 3, maximum: 40 },
              uniqueness: true
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :bio, length: { maximum: 500 }
  validates :website, length: { maximum: 255 }
  validates :location, length: { maximum: 255 }

  has_many :toots
end
