class AddPhoneDisplayAddressToRestaurant < ActiveRecord::Migration
  def self.up
    change_table :restaurants do |t|
      t.string :display_address, array: true, null: false
      t.string :phone, null: false
      t.json :coordinate, null: false
    end
  end

  def self.down
    change_table :restaurants do |t|
      t.remove :display_address
      t.remove :phone
      t.remove :coordinate
    end
  end
end
