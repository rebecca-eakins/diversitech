class GoalsController < ApplicationController
  def index
    @goals = Goal.all
  end

  def show
  end
end