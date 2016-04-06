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

  it "creates a follow when given valid arguments" do
    follow = Follow.new(follower_id: user1.id, followed_id: user.id)
    expect(follow.save).to equal true
  end

  it "gets a follow" do 
    follow = Follow.new(follower_id: user1.id, followed_id: user.id)
    follow.save
    expect(Follow.getFollow({follower_id: user1.id, followed_id: user.id})).to eq follow
  end
end
