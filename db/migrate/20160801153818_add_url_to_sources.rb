class AddUrlToSources < ActiveRecord::Migration
  def self.up
    change_table :restaurants do |t|
      t.text :url, null: false, default: ''
    end
  end

  def self.down
    change_table :restaurants do |t|
      t.remove :url
    end
  end
end
