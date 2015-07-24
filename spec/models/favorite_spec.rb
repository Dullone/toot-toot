require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user)  { FactoryGirl.create(:user) }
  let(:toot)  { FactoryGirl.create(:toot) }
  let(:favorite) { user.favorites.create(toot: toot) }

  it "can have a user" do 
    expect(favorite.user).to equal user
  end
  it "can have a toot" do 
    expect(favorite.toot).to equal toot
  end
end
