class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.string :name, :null => false, :default => ''
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sources
  end
end
