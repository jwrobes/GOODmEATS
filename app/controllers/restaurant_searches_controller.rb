class RestaurantSearchesController < ApplicationController
  def show
    @restaurant_search = RestaurantSearch.new(restaurant_search_params_for_show)
    @results = results
  end

  def create
    redirect_to restaurant_searches_path(restaurant_search_params)
  end

  private

  def restaurant_search_params_for_show
    params.permit(:query, :location)
  end

  def restaurant_search_params
    params.require(:restaurant_search).permit(:query, :location)
  end

  def results
    @restaurant_search.results
  end
end
