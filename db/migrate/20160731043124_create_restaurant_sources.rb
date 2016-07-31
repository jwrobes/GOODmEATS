class CreateRestaurantSources < ActiveRecord::Migration
  def self.up
    create_table :restaurant_sources do |t|
      t.belongs_to :restaurant, :source
      t.timestamps null: false
    end
  end
  def self.down
    drop_table :restaurant_sources
  end
end
