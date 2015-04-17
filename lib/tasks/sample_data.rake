namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_connections
    make_institutions
    make_resources
    make_posts
    associate_user_institution
    tag_posts_with_topics
  end
end

def make_users
  100.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    password = "password123"
    bio = Faker::Lorem.paragraph
    facebook = Faker::Internet.domain_name
    twitter = Faker::Internet.domain_name
    github = Faker::Internet.domain_name
    location_id = rand(1..Location.all.count)
    User.create!(name: name, email: email, password: password, password_confirmation: password, bio: bio, facebook: facebook, twitter: twitter, github: github, location_id: location_id)
  end
end

def make_connections
  users = User.all
  followers = users[10..50]
  targets = users[1..15]
  
  users.each do |user|
    user.follow!(targets.sample)
  end

  followers.each do |user|
    user.follow!(users.sample)
  end

end


def make_institutions
  25.times do |i|
    institution_name = Faker::Company.name
    Institution.create!(name: institution_name)
  end
end

def make_resources
  resource_types = %w(book blog tutorial meetup conference course)
  30.times do |r|
    title = Faker::App.name
    description = Faker::Hacker.say_something_smart
    resource_type = resource_types.sample
    url = Faker::Internet.domain_name
    r = Resource.create!(title: title, description: description, resource_type: resource_type, url: url)
    r.topics.push(Topic.all.sample)
  end
end

def make_posts
  5.times do 
    User.all.limit(6).each do |user|
      user.posts.create!(content: Faker::Lorem.sentence(3), goal_id: rand(1..Goal.count))
    end
  end
end

def associate_user_institution
  User.all.each do |user|
    school_or_work = (1==rand(2) ? "school" : "work")
    started_at = (rand(14).years.ago)
    stopped_at = started_at + rand(50).weeks
    inst_id = Institution.all.sample.id

    user.user_institutions.create(
      institution_type: school_or_work,
      institution_id: inst_id,
      start_date: started_at,
      end_date: stopped_at
      )
  end

  def tag_posts_with_topics
    Post.all.each do |post|
      post.topics.push(Topic.all.sample)
      post.save
    end
  end
end

