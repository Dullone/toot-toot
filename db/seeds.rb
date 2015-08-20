# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Users
user1 = User.create(
    name: "Ruby",
    email: "Ruby@example.com",
    username: "Ruby",
    password: "password",
    password_confirmation: "password"
  )
user2 = User.create(
    name: "Might",
    email: "Mighty@example.com",
    username: "Might",
    password: "password",
    password_confirmation: "password"
  )
#User toots
user1.toots.create(
  message: "Ruby: My first toot."
 )
user1.toots.create(
  message: "This is a long toot that I hope you'll read the whole thing and that is awesome. Second sentence longer than the first. Hello world of toot"
 )
user2.toots.create(
  message: "Mighty toots!"
  )
10.times do 
  user1.toots.create(
    message: Faker::Lorem.sentence(3, false, 4)
    )
end
#User follows
user1.active_follows.create(
  followed: user2
  )

#User retoots