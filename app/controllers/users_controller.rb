class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def edit
    @institutions_array = Institution.all.map { |institution| [institution.name, institution.id] }.sort
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
