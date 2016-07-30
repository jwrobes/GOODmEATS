class CreateRestaurantsTable < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name, :null => false, :default => ''
      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
