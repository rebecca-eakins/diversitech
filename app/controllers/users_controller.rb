class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def edit
    @institutions_array = Institution.all.map { |institution| [institution.name, institution.id] }.sort
  end

  def update
    #specifically zip code
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
