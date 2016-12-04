module TootCreation

  def create_mentions(toot)
    parsedToot = Toot.parse(toot.message)

    parsedToot[:mentions].each do |u|
      user = User.ci_find_by_username u
      if user
        mention = toot.mentions.new user: user
        mention.save!
      end
    end
  end

  def create_tags(toot)
    hasthtags = toot.message.downcase.scan(/#[a-z_]{#{Tag::MIN_LENGTH},#{Tag::MAX_LENGTH}}/)
    
    hasthtags.each do  |tag|
      thisTag = Tag.find_by_tag(tag)
      unless thisTag #if tag doesn't exit, create it
        thisTag = Tag.new(tag: tag)
        thisTag.save!
      end
      tagged = Tagged.new(tag: thisTag, toot: toot)
      tagged.save!
    end
  end

  def create_toot(message, user)
    toot = user.toots.new(message: message)

    begin
      Toot.transaction do
        toot.save!
        create_mentions(toot)
        create_tags(toot)
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    toot
  end
  
end