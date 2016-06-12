module TootsHelper

  def feedUpdate
    lastUpdate = session[:lastfeedUpdate]
    newToots = []
    
    if lastUpdate
      #get feed

    else 
      session[:lastfeedUpdate] = Time.now
    end

    session[:lastfeedUpdate] = Time.now
    newToots
  end

  #def create_mention_links(message)
    #  parsedToot = Toot.parse(message)
    #  messageWithLinks = []
    #
    #  startIndex = 0
    #  parsedToot[:mentions].each do |u|
    #    user = User.ci_find_by_username u 
    #    if user 
    #      endIndex = message.downcase.index("@" + u) - 1
    #      if endIndex > 0 #make sure we aren't at toot begining
    #        messageWithLinks << { message: message[startIndex .. endIndex], type: :text }
    #      end
    #      messageWithLinks << { message: message[endIndex + 1 .. endIndex + u.length + 1], 
    #                            type: :link, link: user_toots_path(user) }
    #      startIndex = endIndex + u.length + 2 #includes @ symbol
    #    end
    #  end
    #
    #  if startIndex < message.length - 1
    #    messageWithLinks << {message: message[startIndex .. -1], type: :text}
    #  end
    #  
    #  messageWithLinks
  #end


  def add_links_to_toot(text)
    add_username_links(text)
    add_tag_links(text)
  end

  def add_username_links(text)
    minLength = User::MIN_USERNAME_LENGTH
    maxLength = User::MAX_USERNAME_LENGTH + 1 # +1 for @ symbol
    usernames = text.scan(/@#{User::VALID_USERNAME_CHARACTERS}{#{minLength},#{maxLength}}/i) #/i case insensitive
    usernames.each do |username|
      text.gsub!(/#{username}\b/, username_link(username))
    end
    text
  end

  def add_tag_links(text)
    tags = text.scan(/#[a-z_]{#{Tag::MIN_LENGTH},#{Tag::MAX_LENGTH}}/i)
    tags.each do  |tag|
      text.gsub!(/#{tag}\b/, tag_link(tag))
    end
    text
  end

  def username_link(at_username)
    username = at_username[1..-1]
    user = User.ci_find_by_username(username)
    if user 
      return link_to at_username, user_path(username)
    end
    at_username
  end

  def tag_link(tag)
    hash_tag = Tag.find_by_tag(tag)
    if hash_tag
      return link_to hash_tag.tag, tag_path(hash_tag)
    end
    tag
  end

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
