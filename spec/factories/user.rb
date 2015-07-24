FactoryGirl.define do 
  factory :user do 
    sequence :username do |n|
      "ruby#{n}"
    end
    sequence :email do |n|
      "Ruby#{n}@ex.com"
    end
    password              "password"
    password_confirmation "password"
    name                   "ruby"
  end
end