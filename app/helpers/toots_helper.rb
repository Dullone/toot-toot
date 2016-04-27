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
        endIndex = message.index("@" + u) - 1
        messageWithLinks << { message: message[startIndex .. endIndex], type: :text }
        messageWithLinks << { message: message[endIndex + 1 .. endIndex + u.length + 1], 
                              type: :link, user_link: user_toots_path(user) }
        startIndex = endIndex + u.length + 2 #includes @ symbol
      end
    end

    puts "startIndex: " + startIndex.to_s + "messege length: " + message.length.to_s

    if startIndex < message.length - 1
      messageWithLinks << {message: message[startIndex .. -1], type: :text}
    end
    
    messageWithLinks
  end

end
