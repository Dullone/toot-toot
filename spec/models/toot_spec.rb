require 'rails_helper'

RSpec.describe Toot, type: :model do
  let(:user)  { FactoryGirl.create(:user) }
  let(:toot)  { user.toots.create(message: "This is a toot.") }
  
  describe "message" do
    it "has a max length of 140" do 
      toot.message = "l" * 141
      expect(toot.save).to eql false
    end
    it "has a minimum legnth of 2" do 
      toot.message = "l" 
      expect(toot.save).to eql false
    end
  end

  describe "favorite" do 
    it "can be favorited" do 
      favorite = user.favorites.create(toot: toot)
      expect(toot.favorites).to include(favorite)
    end
  end
end
