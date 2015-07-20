require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

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
  end
end