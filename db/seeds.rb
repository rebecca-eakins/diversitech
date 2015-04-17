# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Goal.create([
  {name: "code"},
  {name: "career"},
  {name: "advocacy"}
])

User.create([
  {name: "Rebecca Shapkins", email: "reb@mailinator.com", password: "12345678", password_confirmation: "12345678"}
])

Institution.create({name: "The Flatiron School"})

User.find(1).user_institutions.create({institution_type: "School", institution_id: 1, start_date: "2015-02-02", end_date: "2015-04-24"})

User.find(1).posts.create({content: "This is my very first post as a new programmer. How do I best present my git repos?", goal_id: 1})

Topic.create([
  {name: "career"},
  {name: "workplace"},
  {name: "imposter syndrome"},
  {name: "ruby on rails"},
  {name: "back end"},
  {name: "javascript"},
  {name: "git"},
  {name: "front end"}
])

career = Topic.find_by(name: "career")
git = Topic.find_by(name: "git")

Post.find(1).topics << career
Post.find(1).topics << git

Topic.find(1).resources.create([
  {description: "GDI is a communit that offers courses for women and girls interested in learning to code.", url: "www.girldevelopit.com", title: "Girl Develop It!", resource_type: "course"}
  ])

Connection.create([
  {follower_id: 1, target_id: 100, connection_status: "confirmed"},
  {follower_id: 1, target_id: 99, connection_status: "confirmed"},
  {follower_id: 1, target_id: 98, connection_status: "confirmed"},
  {follower_id: 100, target_id: 1, connection_status: "confirmed"},
  {follower_id: 100, target_id: 99, connection_status: "confirmed"}
])

Location.create([
  {zip: "11216", city: "Brooklyn", state: "NY"},
  {zip: "10007", city: "New York", state: "NY"},
  {zip: "10014", city: "New York", state: "NY"},
  {zip: "11222", city: "Brooklyn", state: "NY"},
  {zip: "10011", city: "New York", state: "NY"},
  {zip: "11217", city: "Brooklyn", state: "NY"},
  {zip: "11215", city: "Brooklyn", state: "NY"},
  {zip: "11231", city: "Brooklyn", state: "NY"},
  {zip: "10001", city: "New York", state: "NY"},
  {zip: "10003", city: "New York", state: "NY"},
  {zip: "11211", city: "Brooklyn", state: "NY"},
  {zip: "10002", city: "New York", state: "NY"},
  {zip: "02203", city: "Boston", state: "MA"},
  {zip: "07030", city: "New Jersey", state: "NJ"},
  {zip: "30334", city: "Atlanta", state: "GA"},
  {zip: "94132", city: "San Francisco", state: "CA"},
  {zip: "92101", city: "San Diego", state: "CA"},
  {zip: "98104", city: "Seattle", state: "WA"}
])







