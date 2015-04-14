class Connection < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :target, class_name: "User"

  validates :follower_id, presence: true
  validates :target_id, presence: true

  validates :connection_status, inclusion: { in: %w(confirmed pending unfollowed),
    message: "%{value} is not a valid status" }, allow_blank: true

  validates_uniqueness_of :follower_id, :scope => :target_id
  validate :cannot_follow_self

  def self.found?(follower, target)
    !!Connection.find_by(follower_id: follower, target_id: target)
  end

  def self.create_new_follow(follower, target)
    Connection.create(follower_id: follower.id, target_id: target.id, connection_status: 'confirmed')
  end

  private
  
  def cannot_follow_self
    if follower_id == target_id
      errors.add(:follower_id, "You cannot follow yourself!")
    end
  end

end