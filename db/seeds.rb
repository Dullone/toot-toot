# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(
    name: "Ruby",
    email: "Ruby@example.com",
    username: "Ruby",
    password: "password",
    password_confirmation: "password"
  )
user1.toots.create(
  message: "My first toot."
 )
user1.toots.create(
  message: "This is a long tweet that I hope you'll read the whole thing and that is awesome. Second sentence longer than the first. Hello world of toot"
 )