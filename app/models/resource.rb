class Resource < ActiveRecord::Base

  has_many :resource_topics
  has_many :topics, through: :resource_topics

  validates :title, :description, presence: true

  validates :resource_type, inclusion: { in: %w(book blog tutorial meetup conference course),
    message: "%{value} is not a valid resource type" }, allow_blank: true
end