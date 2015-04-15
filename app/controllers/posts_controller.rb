class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    #redirect_to tab self-selected by user as primary interest.
  end

  def show
    @post = Post.find(params[:id])
  end
 
end