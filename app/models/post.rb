class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  has_many :post_topics
  has_many :topics, through: :post_topics

  validates :content, presence: true
end
