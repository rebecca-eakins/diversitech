class Institution < ActiveRecord::Base

  has_many :user_institutions
  has_many :users, through: :user_institutions

  validates :name, presence: true
  validates :name, uniqueness: true

end
