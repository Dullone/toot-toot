class Favorite < ActiveRecord::Base
  belongs_to :toot
  belongs_to :user

  #validations
  validates :user, presence: true
  validates :toot, presence: true
end
