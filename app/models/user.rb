class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :first_name, :last_name, presence: true

  has_many :user_institutions
  has_many :institutions, through: :user_institutions
  
  has_many :posts

  
end
