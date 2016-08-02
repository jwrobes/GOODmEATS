class RemoveUrlFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :url, :string
  end
end
