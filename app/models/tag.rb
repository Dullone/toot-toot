class Tag < ActiveRecord::Base
  MAX_LENGTH = 20
  MIN_LENGTH = 4
  validates :tag, length: { minimum: MIN_LENGTH, maximum: MAX_LENGTH }, 
                  uniqueness: true 
end
