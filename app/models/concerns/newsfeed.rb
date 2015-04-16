class Newsfeed
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(current_user)
    @user = current_user
  end

  def persisted?
    false
  end

  def parse_recent_follows_for_feed
    @user.recent_follows.collect do |connection|
      [connection, connection.created_at, "connection"]
    end
  end

  def parse_recent_posts_for_feed
    @user.recent_posts_from_targets.collect do |post|
      # if post.goal
      #   ["#{post.user.name} added a new post under #{post.goal.name.capitalize} on #{post.created_at.strftime("%m/%d/%y")} at #{post.created_at.strftime("%l:%M %p")}", post.created_at, "post"]
      # else
      #   ["#{post.user.name} added a new post on #{post.created_at.strftime("%m/%d/%y")} at #{post.created_at.strftime("%l:%M %p")}", post.created_at, "post"]
      # end
      [post, post.created_at, "post"]
    end
  end

  def recent_follows
    
  end

  def display_feed
    feed = []
    parse_recent_follows_for_feed.each {|item| feed << item }
    parse_recent_posts_for_feed.each {|item| feed << item }
    feed
    feed.sort! do |x,y|
      x[1] <=> y[1]
    end.reverse!
  end

end