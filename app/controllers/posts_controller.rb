class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, :only => [:show, :edit, :update]

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

      if params[:post][:topics]
        params[:post][:topics].each do |topic|
          @post.topics << Topic.find(topic)
        end
      end

      if params[:post][:topics]
        @post.topics.create(name: params[:post][:topic][:name]) if params[:post][:topic][:name] != ""
        redirect_to posts_path
      end
      redirect_to :back
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
    if @post.parent_post_id.nil?
      redirect_to posts_path
    else
      redirect_to posts_path(@post.parent_post_id)
    end
  end

  def destroy
    find_post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :content, :topics, :topic, :goal_id, :parent_post_id)
  end
 
end