class Toot < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :user

  #validations
  validates :message, length: { minimum: 2, maximum: 140 }
  validates :user, presence: true

  #favorites
  has_many :favorites
  #retoot
  has_many :retoots

  def self.parse(message)
    unless message && message.length > 1
      return false
    end

    parsedToot = {}
    minLength = User::MIN_USERNAME_LENGTH
    maxLength = User::MAX_USERNAME_LENGTH
    if message[0] == '@' #toot directed at a user
      parsedToot[:directedAt] = message.downcase.scan(/^@[a-z_]{#{minLength},#{maxLength}}/).first
    end
    parsedToot[:mentions] = message.downcase.scan(/@[a-z_]{#{minLength},#{maxLength}}/)
    parsedToot
  end

end
