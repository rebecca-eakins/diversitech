class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  validates :name, presence: true

  belongs_to :location

  has_many :user_institutions
  has_many :institutions, through: :user_institutions
  
  has_many :posts

  # HAS MANY FOLLOWERS
  has_many :followers, foreign_key: :target_id, class_name: "Connection"

  # FOLLOWS MANY USERS
  has_many :targets, foreign_key: :follower_id, class_name: "Connection"


  #CLASS METHODS

  def self.github_user_exist?(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  def self.devise_user_exist?(params_hash)
    where(name: params_hash[:name], email: params_hash[:email]).first
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

  def latest_institution_name
    inst_id = self.user_institutions.order("end_date DESC").first.institution_id
    if !inst_id.nil?
      Institution.find(inst_id).name
    else
      "Tech Community Member"
    end
  end

  def formatted_location
    if self.location
      "#{self.location.city}, #{self.location.state}"
    else
      "Somewhere, USA"
    end
  end

  def feature_image
    if self.image == nil
      "default.png"
    else
      self.image
    end
  end

  def first_name
    self.name.split(" ").first
  end

  # NETWORK INSTANCE METHODS

  def feed(goal = 'all')
    if goal == 'all'
      Post.from_users_followed_by(self)
    else
      Post.from_users_followed_by(self).where(goal_id: Goal.find_by(name: goal))
    end
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
