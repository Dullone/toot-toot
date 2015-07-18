require 'rails_helper'

RSpec.describe Toot, type: :model do
  let(:toot) { FactoryGirl.create(:toot) }
  describe "message" do
    it "has a max length of 140" do 
      toot.message = "l" * 141
      expect(toot.save).to eql false
    end
  end
end
