class RestaurantsController < ApplicationController
  def new
    @new_restaurant = new_restaurant
    @restaurant = Restaurant.new
  end

  def index
    @restaurants = Restaurant.all
  end

  private

  def new_restaurant_params
    params.require(:result).permit!
  end

  def new_restaurant
    OpenStruct.new(new_restaurant_params)
  end
end
