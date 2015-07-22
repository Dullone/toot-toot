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

end
