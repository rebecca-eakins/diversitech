class SearchController < ApplicationController
  before_action :authenticate_user!


  def show
    @search_term = params["search"]["search_term"].downcase
    search_results
  end

private

  def search_results
    category = params["category"]
    if category == "Discussion" || category == "None"
      @post_results = Post.where("content like '%#{@search_term}%'")
    end
    if category == "Resource" || category == "None"
      @resource_results = Resource.where("description like '%#{@search_term}%'")
    end
  end

end