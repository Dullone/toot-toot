module TootCreation

  def create_mentions(toot)
    parsedToot = Toot.parse(toot.message)

    parsedToot[:mentions].each do |u|
      user = User.ci_find_by_username u
      if user
        toot.mentions.create user: user
      end
    end
  end

  def create_tags(toot)
    hasthtags = toot.message.downcase.scan(/#[a-z_]{#{Tag::MIN_LENGTH},#{Tag::MAX_LENGTH}}/)
    
    hasthtags.each do  |tag|
      thisTag = Tag.find_by_tag(tag)
      unless thisTag #if tag doesn't exit, create it
        thisTag = Tag.create(tag: tag)
      end
      Tagged.create(tag: thisTag, toot: toot)
    end
  end

  def create_toot(message, user)
    toot = user.toots.new(message: message)
    if toot.save
      create_mentions(toot)
      create_tags(toot)
      return toot
    else
      return false
    end
  end
  
end