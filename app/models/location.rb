class Location < ActiveRecord::Base

  has_many :users

  validates :zip, length: { is: 5 }
  validates :zip, uniqueness: true

  def users_in_same_city
    city = self.city

    city_query = <<-SQL

      SELECT * FROM users u 
      WHERE u.location_id IN (
        SELECT id FROM locations loc 
        WHERE city = ?);

    SQL

    User.find_by_sql([city_query, city])
  end

  def users_in_same_state
    state = self.state

    state_query = <<-SQL

      SELECT * FROM users u 
      WHERE u.location_id IN (
        SELECT id FROM locations loc 
        WHERE state = ?);

    SQL

    User.find_by_sql([state_query, city])
  end

end