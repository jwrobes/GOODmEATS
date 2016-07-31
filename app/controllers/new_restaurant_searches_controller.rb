class NewRestaurantSearchesController < ApplicationController
  def show
    @new_restaurant_search = NewRestaurantSearch.new(restaurant_search_params)
    @results = results
  end

  def create
    redirect_to new_restaurant_searches_path(new_restaurant_search_params)
  end

  private

  def restaurant_search_params
    params.permit(:query, :location)
  end

  def new_restaurant_search_params
    params.require(:new_restaurant_search).permit(:query, :location)
  end

  def results
    @new_restaurant_search.results
  end
end
