class UsersController < ApplicationController
  before_action :find_user

  def show
    if Connection.found?(current_user, @user)
      @connection = Connection.find_by(follower_id: current_user, target_id: @user)
    else
      @connection = Connection.new
    end
  end

  def edit
    if current_user.id == params[:id].to_i
      @institutions_array = Institution.all.map { |institution| [institution.name, institution.id] }.sort
    else
      flash[:alert] = "You are not authorized to view that page, sorry!"
      redirect_to user_path(params[:id])
    end
  end

  def update
    @user.current_zip = params[:user][:current_zip]
    @user.name = params[:user][:name]
    @user.save
    redirect_to :back
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
