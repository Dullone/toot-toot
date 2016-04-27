class Mention < ActiveRecord::Base
  belongs_to :user
  belongs_to :toot
end
