class PostLink < ActiveRecord::Base

  belongs_to :parent_post, class_name: "Post"
  belongs_to :child_post, class_name: "Post"

  validates :parent_post, presence: true
  validates :child_post, presence: true

  def self.found?(child_post, parent_post)
    !!PostLink.find_by(child_post_id: child_post, parent_post_id: parent_post)
  end

  def self.create_new_post_link(child_post, parent_post)
    PostLink.create(child_post_id: child_post.id, parent_post_id: parent_post.id)
  end

end