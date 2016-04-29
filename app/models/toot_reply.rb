class TootReply < ActiveRecord::Base
  belongs_to :toot
  belongs_to :reply_toot, :class_name => "Toot"

  validates_uniqueness_of :toot, scope: :reply_toot
end