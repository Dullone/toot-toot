require 'rails_helper'

RSpec.describe Retoot, type: :model do
  let(:user)  { FactoryGirl.create(:user) }
  let(:toot)  { user.toots.create(message: "Toot") }
  let(:retoot) { user.retoots.create(toot: toot)}
  
  it "has a usesr" do 
    expect(retoot.user).to equal user
  end
  it "has a toot" do 
    expect(retoot.toot).to equal toot
  end
end
