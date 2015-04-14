class InstitutionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @institution = Institution.create(name: params[:institution][:name])
    session[:institution] = @institution
    redirect_to :back #figure out how to set the institution in the dropdown by default.
  end
end