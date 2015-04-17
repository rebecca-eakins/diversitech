class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  has_many :post_topics
  has_many :topics, through: :post_topics

  validates :content, presence: true
  validates :goal_id, presence: true

  default_scope {order('posts.created_at DESC')}
  scope :from_users_followed_by, lambda { |user| followed_by(user)} # DOESN'T QUIIIITE WORK YET

  accepts_nested_attributes_for :topics

  def child_posts
    Post.unscoped.where("parent_post_id == ?", self.id)
  end

  private
    def self.followed_by(user)
      following_ids = %(SELECT target_id FROM connections
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
    end
end
