module ApplicationHelper
    def date_distance_in_words_short(date)
    if Time.now - date < 1.days
      time_ago_in_words(date)
    elsif Time.now - date < 1.years
      date.strftime('%b %e')
    else
      date.strftime('%e %b %Y')
    end
  end
end
