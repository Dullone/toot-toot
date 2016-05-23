class Toot < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :user

  #validations
  MIN_LENGTH = 2
  MAX_LENGTH = 140
  validates :message, length: { minimum: MIN_LENGTH, maximum: MAX_LENGTH }
  validates :user, presence: true

  #favorites
  has_many :favorites, dependent: :destroy
  #retoot
  has_many :retoots, dependent: :destroy
  #mentions
  has_many :mentions, dependent: :destroy
  #reply
  #has_one :orginal_toot, class_name: "TootReply", foreign_key: "reply_toot_id"
  has_many :reply_toots, class_name: "TootReply", foreign_key: "toot_id"
  has_many :replies, through: :reply_toots, source: :reply_toot
  #tags
  has_many :taggeds, dependent: :destroy

  def self.parse(message)
    unless message && message.length > 1
      return false
    end

    parsedToot = {}
    parsedToot[:mentions] = []
    minLength = User::MIN_USERNAME_LENGTH
    maxLength = User::MAX_USERNAME_LENGTH + 1 # +1 for @ symbol

    if message[0] == '@' #toot directed at a user
      parsedToot[:directedAt] = message.downcase.scan(/^@[a-z_]{#{minLength},#{maxLength}}/).first
    end
    mentions = message.downcase.scan(/(?:@)([a-z_]{#{minLength},#{maxLength}})/)
    mentions.each do |m| #scan gave us an array of arrays as we used capture groups
      parsedToot[:mentions] << m.first
    end
    parsedToot
  end
end
