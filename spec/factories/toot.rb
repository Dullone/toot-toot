FactoryGirl.define do 
  factory :toot do 
    sequence :message do |n|
      "This is a toot #{n}"
    end
  end
end