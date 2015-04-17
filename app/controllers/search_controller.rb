class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :search_term, only: [:show_posts, :show_users]

  def show_posts
    search_posts
    respond_to do |f|
      f.js {}
      f.html {}
    end
  end

  def show_users
    search_users
    respond_to do |f|
      f.js {}
      f.html {}
    end
  end

  def clear
    respond_to do |f|
      f.js {}
      f.html {redirect_to posts_path}
    end
  end

private

  def search_term
    @search_term = params["search"]["search_term"].downcase
  end

  def search_posts
    @post_results = Post.where("content like '%#{@search_term}%'")
  end

  def search_users
    @user_results = User.where("name like '%#{@search_term}%'")
  end

end