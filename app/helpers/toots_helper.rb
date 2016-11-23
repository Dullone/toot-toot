module TootsHelper

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
      return link_to at_username, user_toots_path(username.downcase)
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

end
