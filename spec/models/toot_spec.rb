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

  describe "parse" do 
    let(:message) { "@ruby, I like @linux, but not @uu.  @abcdefghijklmnopqrstuvwxyz" }

    it "returns who toot is directed at" do
      expect(Toot.parse(message)[:directedAt]).to eql "@ruby"
    end

    it "returns mentions" do 
      expect(Toot.parse(message)[:mentions]).to include("@linux")
      expect(Toot.parse(message)[:mentions]).to include("@ruby")
      expect(Toot.parse(message)[:mentions]).not_to include("like")
    end

    it "doesn't return mentions with username less than 3" do 
      expect(Toot.parse(message)[:mentions]).not_to include("@uu")
    end
    it "doesn't return mentions with username greater than 20" do 
      expect(Toot.parse(message)[:mentions]).not_to include("@uu")
    end
  end
end
