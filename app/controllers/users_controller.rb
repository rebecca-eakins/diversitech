class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!


  def show
    if Connection.found?(current_user, @user)
      @connection = Connection.find_by(follower_id: current_user, target_id: @user)
    else
      @connection = Connection.new
    end
  end

  def edit
    @inst_id = session[:institution]["id"] || 1

    if current_user.id == params[:id].to_i
      @institutions_array = Institution.all.map { |institution| [institution.name, institution.id] }.sort
    else
      flash[:alert] = "You are not authorized to view that page, sorry!"
      redirect_to user_path(params[:id])
    end
    @user_institutions = UserInstitution.where(user_id: current_user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(item_params)
    redirect_to :back
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def item_params
    params.require(:user).permit(:email, :name, :image, :current_zip)
  end
  
end
