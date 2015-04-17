class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.select(:city).uniq
  end

  def show
    @location = Location.find(params[:id])
  end
end