class RemoveDefaultForApiIdInRestaurants < ActiveRecord::Migration
  def change
    change_column :restaurants, :api_id, :string, :null => false
  end
end
