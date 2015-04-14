class SearchController < ApplicationController
  before_action :authenticate_user!

  def show
    @search_term = params["search"]["search_term"].downcase
    search_results
    respond_to do |f|
      f.js {}
      f.html {}
    end
  end

private

  def search_results
    @post_results = Post.where("content like '%#{@search_term}%'")
  end

end