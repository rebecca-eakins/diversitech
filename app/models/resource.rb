class Resource < ActiveRecord::Base

  has_many :resource_topics
  has_many :topics, through: :resource_topics

  validates :title, :description, presence: true
end
