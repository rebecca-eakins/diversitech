class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  validates :name, presence: true

  validates :current_zip, length: { is: 5 }, :allow_blank => true

  has_many :user_institutions
  has_many :institutions, through: :user_institutions
  
  has_many :posts

  # HAS MANY FOLLOWERS
  has_many :followers, foreign_key: :target_id, class_name: "Connection"

  # FOLLOWS MANY USERS
  has_many :targets, foreign_key: :follower_id, class_name: "Connection"


  #CLASS METHODS

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

  # INSTANCE METHODS

  def first_name
    self.name.split(" ").first
  end

  # NETWORK INSTANCE METHODS

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(target)
    !!targets.find_by(target_id: target, connection_status: 'confirmed')
  end

  def follow!(target)
    follower = self
    
    if Connection.found?(follower, target)
      Connection.find_by(follower_id: follower, target_id: target).update(connection_status: "confirmed")
    else
      Connection.create_new_follow(follower, target)
    end
  end

  def unfollow!(target)
    follower = self
    Connection.find_by(follower_id: follower.id, target_id: target.id).update_column(:connection_status, "unfollowed")
  end

  # NETWORK HELPERS

  def following
    id = self.id

    following_query = <<-SQL
      SELECT * FROM users u
      WHERE u.id IN (SELECT target_id FROM
      connections c WHERE c.follower_id = ?
      AND c.connection_status = 'confirmed');
    SQL

    User.find_by_sql([following_query, id])
  end

  def followed_by
    # TODO: sort out the naming here. Because of Active Record, 'followers' is a method we get from the follower_id column on the connections table. target.followers, though, returns a collection of *CONNECTIONS*, not a collection of USER objects. Naming this method, which returns USER objects, "followers" may be intuitive, but it results in namespace conflict. Buh? Renamed 'followed_by' for now to manage this collision.

    id = self.id

    following_query = <<-SQL
      SELECT * FROM users u
      WHERE u.id IN (SELECT follower_id FROM
      connections c WHERE c.target_id = ?
      AND c.connection_status = 'confirmed');
    SQL

    User.find_by_sql([following_query, id])
  end

end
