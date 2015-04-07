# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {name: "Rebecca Shapkins", email: "reb@mailinator.com", password: "12345678", password_confirmation: "12345678"}
])

Institution.create({name: "The Flatiron School"})

User.find(1).user_institutions.create({institution_type: "School", institution_id: 1, start_date: "2015-02-02", end_date: "2015-04-24"})

User.find(1).posts.create({content: "This is my very first post as a new programmer. How do I best present my git repos?"})

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







