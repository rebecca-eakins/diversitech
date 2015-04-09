class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  validates :name, presence: true

  validates :current_zip, length: { is: 5 }

  has_many :user_institutions
  has_many :institutions, through: :user_institutions
  
  has_many :posts

  def self.user_exist?(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  # def self.from_omniauth(auth)
  #   if !self.user_exist?(auth)
  #     User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20], name: auth.info.name, image: auth.info.image)
  #   else
  #     user
  #   end
  # end

  def first_name
    self.name.split(" ").first
  end
  
end