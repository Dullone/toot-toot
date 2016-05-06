class TootReply < ActiveRecord::Base
  validates :toot_id, presence: true
  validates :reply_toot_id, presence: true

  belongs_to :toot, dependent: :destroy
  belongs_to :reply_toot, :class_name => "Toot", dependent: :destroy

  validates_uniqueness_of :toot, scope: :reply_toot

  before_save :check_if_reply_to_reply


  def check_if_reply_to_reply
    !TootReply.toot_is_reply?(self.toot_id)
  end

  def self.toot_is_reply?(toot_id)
    if TootReply.where("reply_toot_id = ?", toot_id).limit(1).length > 0
      return true
    end
    false
  end

end