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

    params[:post][:topics].each do |topic|
      @post.topics << Topic.find(topic)
    end

    @post.topics.create(name: params[:post][:topic][:name]) if params[:post][:topic][:name] != ""

    redirect_to posts_path

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :content, :topics, :topic, :goal_id)
  end
 
end