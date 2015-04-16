class Location < ActiveRecord::Base

  validates :zip, length: { is: 5 }
  validates :zip, uniqueness: true

  validates :city, :state, presence: true
end
