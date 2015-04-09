class Connection < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :target, class_name: "User"

  validates :follower_id, presence: true
  validates :target_id, presence: true

  validates_uniqueness_of :follower_id, :scope => :target_id
  validate :cannot_follow_self


  private
  
  def cannot_follow_self
    if follower_id == target_id
      errors.add(:follower_id, "You cannot follow yourself!")
    end
  end

end
