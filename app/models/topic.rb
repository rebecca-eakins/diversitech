class Topic < ActiveRecord::Base

  has_many :post_topics
  has_many :posts, through: :post_topics

  has_many :resource_topics
  has_many :resources, through: :resource_topics

  validates :name, presence: true

end
