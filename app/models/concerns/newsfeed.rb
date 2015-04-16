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
      [post, post.created_at, "post"]
    end
  end

  def display_feed
    feed = []
    parse_recent_follows_for_feed.each {|item| feed << item }
    parse_recent_posts_for_feed.each {|item| feed << item }
    feed.sort! { |x,y| y[1] <=> x[1] }
  end

end