class Retoot < ActiveRecord::Base
  belongs_to :user
  belongs_to :toot

  validates_uniqueness_of :toot, scope: :user
end
