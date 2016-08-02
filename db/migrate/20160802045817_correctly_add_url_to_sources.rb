class CorrectlyAddUrlToSources < ActiveRecord::Migration
  def self.up
    change_table :sources do |t|
      t.text :url, null: false, default: ''
    end
  end

  def self.down
    change_table :sources do |t|
      t.remove :url
    end
  end
end
