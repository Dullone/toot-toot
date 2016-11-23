require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)  { FactoryGirl.create(:user) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:toot)  { user.toots.create(message: "Toot") }
  let(:user1Toot1) { user1.toots.create(message: "Toot 1", created_at: (Time.now - 3.minutes)) }
  let(:user1Toot2) { user1.toots.create(message: "Toot 2", created_at: Time.now)  }
  let(:retoot){ user.retoots.create(toot: toot)}

  describe "atrributes"  do 
    it "must have an email" do 
      user.email = ""
      expect(user.save).to eql false
    end
    it "requires a username shorter than 3 characters" do 
      user.username = ""
      expect(user.save).to eql false
    end
    it "can't have a username longer than 20 characters" do 
      user.username = "k" * 21
      expect(user.save).to eql false
    end
    it "username can't contain invalid characters" do 
      user.username = "@meyou"
      expect(user.save).to eql false
    end
    it "cant' have a bio longer than 500" do 
      user.bio = "k" * 501
      expect(user.save).to eql false
    end
    it "can have a bio" do 
      user.bio = "j" * 10
      expect(user.save).to eql true
    end
    it "can have a location shorter than 255 characters" do 
      user.location = "j" * 20
      expect(user.save).to eql true
      user.location = "j" * 256
      expect(user.save).to eql false
    end
    it "can have a website shorter than 255 characters" do 
      user.website = "j" * 20
      expect(user.save).to eql true
      user.website = "j" * 256
      expect(user.save).to eql false
    end
    it "can have a name 2 to 40 characters" do 
      user.name = "j" 
      expect(user.save).to eql false
      user.name = "j" * 40
      expect(user.save).to eql true
      user.name = "j" * 41
      expect(user.save).to eql false
    end
    it "has at_username" do 
      user.save
      expect(user.at_username).to eql ('@' + user.username)
    end
  end

  describe "follows" do 
    it "can follow another user" do 
      user.active_follows.create(followed: user1)
      expect(user.following).to include(user1)
    end
    it "can be followed by a user" do 
      user.active_follows.create(followed: user1)
      expect(user1.followers).to include(user)
    end
  end

  describe "favorites" do 
    it "can favorite toots" do 
      favorite = user.favorites.create(toot: toot)
      expect(user.favorites).to include(favorite)
    end
  end

  describe "feed" do 

    before(:each) do 
      user.active_follows.create(followed: user1)
      user1Toot1
    end

    it "contains toots of usering being followed" do 
      expect(user.feed).to include(user1Toot1)
    end
    it "contains user followed and retoots" do 
      user.retoots.create(toot: user1Toot2)
      expect(user.feed).to include(user1Toot1)
      expect(user.feed).to include(user1Toot2)
    end

    it "gets new toots since a given Time" do
      last_update = Time.now - 2.minutes
      user1Toot2
      new_toots = user.getFeedTootsSince(last_update)
      expect(new_toots).to      include user1Toot2
      expect(new_toots).not_to  include user1Toot1
    end

  end

end