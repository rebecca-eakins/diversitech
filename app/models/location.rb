class Location < ActiveRecord::Base

  validates :zip, length: { is: 5 }
  validates :zip, uniqueness: true

end
