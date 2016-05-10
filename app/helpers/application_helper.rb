module ApplicationHelper
  include RetootsHelper
  include TootsHelper
  include TootRepliesHelper
  
  def login_required
    "login required"
  end

  def date_distance_in_words_short(date)
    if Time.now - date < 1.days
      time_ago_in_words(date)
    elsif  Time.now.year == date.year 
      date.strftime('%b %e')
    else
      date.strftime('%e %b %Y')
    end
  end
end
