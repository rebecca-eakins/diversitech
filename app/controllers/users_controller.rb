class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :list_institutions, only: [:show, :edit]
  before_action :find_user, only: [:show, :edit, :update]


  def show
    if Connection.found?(current_user, @user)
      @connection = Connection.find_by(follower_id: current_user, target_id: @user)
    else
      @connection = Connection.new
    end    
  end

  def edit
    @inst_id = session[:institution]["id"] if session[:institution]

    if current_user.id == params[:id].to_i
    else
      flash[:alert] = "You are not authorized to view that page, sorry!"
      redirect_to user_path(params[:id])
    end
    @user_institutions = UserInstitution.where(user_id: current_user.id)
  end

  def update
    @user.update(user_params)
    redirect_to :back
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio, :facebook, :twitter, :github)
  end

  def list_institutions
    @institutions_array = Institution.all.collect do |inst|
       [inst.name, inst.id]
      end.sort
  end
  
end
