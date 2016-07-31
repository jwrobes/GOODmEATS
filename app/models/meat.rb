class Meat < ActiveRecord::Base
  has_many :restaurant_meats
  has_many :restaurants, through: :restaurant_meats
end
