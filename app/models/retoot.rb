class Retoot < ActiveRecord::Base
  belongs_to :user
  belongs_to :toot
end
