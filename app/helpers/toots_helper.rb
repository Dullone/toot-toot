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

  def create_mention_links(message)
    parsedToot = Toot.parse(message)
    messageWithLinks = []

    startIndex = 0
    parsedToot[:mentions].each do |u|
      user = User.ci_find_by_username u 
      if user 
        endIndex = message.downcase.index("@" + u) - 1
        if endIndex > 0 #make sure we aren't at toot begining
          messageWithLinks << { message: message[startIndex .. endIndex], type: :text }
        end
        messageWithLinks << { message: message[endIndex + 1 .. endIndex + u.length + 1], 
                              type: :link, user_link: user_toots_path(user) }
        startIndex = endIndex + u.length + 2 #includes @ symbol
      end
    end

    if startIndex < message.length - 1
      messageWithLinks << {message: message[startIndex .. -1], type: :text}
    end
    
    messageWithLinks
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

  def create_toot(message, user)
    toot = user.toots.new(message: message)
    if toot.save
      create_mentions(toot)
      return toot
    else
      return false
    end
  end

end
