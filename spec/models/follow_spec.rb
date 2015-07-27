require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user)   { FactoryGirl.create(:user) }
  let(:user1)  { FactoryGirl.create(:user) }
  let(:followUser){ Follow.new(followed_id: user1, follower_id: user )  }

  it "requires a follower_id" do 
    follow = Follow.new(followed_id: user1.id)
    expect(follow.save).to equal false
  end
  it "requires a followed_id" do 
    follow = Follow.new(follower_id: user1.id)
    expect(follow.save).to equal false
  end
end
