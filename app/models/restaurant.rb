class Restaurant < ActiveRecord::Base
  has_many :restaurant_sources
  has_many :sources, through: :restaurant_sources

  has_many :restaurant_meats
  has_many :meats, through: :restaurant_meats

  validates :name, :api_id, :display_address,
            :phone, :coordinate, presence: true
end
