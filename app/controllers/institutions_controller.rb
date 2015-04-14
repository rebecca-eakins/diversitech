class InstitutionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @institution = Institution.create(name: params[:institution][:name])
    session[:institution] = @institution
    redirect_to :back #figure out how to pass in @institution as a local to users/profile/edit
  end

  # TODO: add strong params for creating new institution.

end