FactoryGirl.define do 
  factory :user do 
    email                 "Ruby@ex.com"
    password              "password"
    password_confirmation "password"
    username               "ruby"
    name                   "ruby"
  end
end