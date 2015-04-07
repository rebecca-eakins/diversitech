class PostsController < ApplicationController

  before_action :find_goal, :only => [:index, :show]

  def index
    #redirect_to tab self-selected by user as primary interest.
  end

  def show
    @post = Post.find(params[:id])
  end
  
end

private

  def find_goal
    @goal = Goal.find(params[:goal_id])
  end