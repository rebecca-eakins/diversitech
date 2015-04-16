class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!


  def show
    if Connection.found?(current_user, @user)
      @connection = Connection.find_by(follower_id: current_user, target_id: @user)
    else
      @connection = Connection.new
    end

    list_institutions
    
  end

  def edit
    @inst_id = session[:institution]["id"] if session[:institution]

    if current_user.id == params[:id].to_i
      list_institutions
    else
      flash[:alert] = "You are not authorized to view that page, sorry!"
      redirect_to user_path(params[:id])
    end
    @user_institutions = UserInstitution.where(user_id: current_user.id)
  end

  def update
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

  def list_institutions
    @institutions_array = Institution.all.collect do |inst|
       [inst.name, inst.id]
      end.sort
  end
  
end
