class Toot < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :user

  #validations
  validates :message, length: { minimum: 2, maximum: 140 }

  #favorites
  has_many :favorites
  #retoot
  has_many :retoots
end
