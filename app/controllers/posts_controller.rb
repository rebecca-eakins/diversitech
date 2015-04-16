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

    # "post"=>{"content"=>"", "user_id"=>"113", ":topics"=>["6"], "topic"=>{"name"=>"lala"}},
  def create
    @post = Post.create(post_params)
    if @post.persisted?

      params[:post][:topics].each do |topic|
        @post.topics << Topic.find(topic)
      end

      @post.topics.create(name: params[:post][:topic][:name]) if params[:post][:topic][:name] != ""
      redirect_to posts_path
    else
      flash.now[:goal_error] = "Please select a goal." if !@post.goal_id
      flash.now[:content_error] = "Please include some text before creating a post." if @post.content == ""
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    params[:post][:topics].each do |topic|
      @post.topics << Topic.find(topic) unless @post.topics.include? Topic.find(topic)
    end
    @post.topics.create(name: params[:post][:topic][:name]) if params[:post][:topic][:name] != ""
    redirect_to posts_path
  end

  # def destroy
  # end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :content, :topics, :topic, :goal_id)
  end
 
end