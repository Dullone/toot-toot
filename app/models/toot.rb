class Toot < ActiveRecord::Base
  belongs_to :user
  validates :message, length: { minimum: 2, maximum: 140 }
end
