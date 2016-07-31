class RestaurantMeat < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :meat
end
