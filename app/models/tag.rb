class Tag < ActiveRecord::Base
  MAX_LENGTH = 20
  MIN_LENGTH = 4
  has_many :taggeds, dependent: :destroy
  has_many :toots, through: :taggeds
  validates :tag, length: { minimum: MIN_LENGTH, maximum: MAX_LENGTH }, 
                  uniqueness: true 
end
