class Source < ActiveRecord::Base
  has_many :restaurant_sources
  has_many :restaurants, through: :restaurant_sources

  validates :name, :url, presence: true
end
