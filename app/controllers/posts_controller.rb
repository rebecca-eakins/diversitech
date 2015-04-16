class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, :only => [:show, :edit, :update, :destroy]

  def index
    #redirect_to tab self-selected by user as primary interest.
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end

  private

  def find_post
    Post.find(params[:id])
  end
 
end