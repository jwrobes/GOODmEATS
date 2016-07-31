class CreateMeats < ActiveRecord::Migration
  def self.up
    create_table :meats do |t|
      t.string :name, :null => false, :default => ''
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :meats
  end
end
