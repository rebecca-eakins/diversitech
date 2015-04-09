class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def edit
    @institutions_array = Institution.all.map { |institution| [institution.name, institution.id] }.sort
  end

  def update
    #not sure exactly what this is going to do yet-> zip code
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
