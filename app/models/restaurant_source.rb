class RestaurantSource < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :source
end
