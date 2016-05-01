class TootReply < ActiveRecord::Base
  validates :toot_id, presence: true
  validates :reply_toot_id, presence: true

  belongs_to :toot, dependent: :destroy
  belongs_to :reply_toot, :class_name => "Toot", dependent: :destroy

  validates_uniqueness_of :toot, scope: :reply_toot
end