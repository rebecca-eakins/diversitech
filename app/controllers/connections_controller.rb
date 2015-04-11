class ConnectionsController < ApplicationController
  before_action :lookup_target_user, only: [:create, :update]
  before_action :authenticate_user!

  def index
    if current_user
      @users_to_view = User.all.sample(5)
      @followers = current_user.followed_by
      @targets = current_user.following
    else
      flash.alert = "You must sign in to see your connections!"
      redirect_to root_path
    end
  end

  def create
    current_user.follow!(@target)
    redirect_to :back
  end

  def update

    if params[:commit] == "Unfollow"
      current_user.unfollow!(@target)
    else
      current_user.follow!(@target)
    end
    redirect_to :back
  end

  private

    def lookup_target_user
      @target = User.find(params[:connection][:target_id])
    end

end
