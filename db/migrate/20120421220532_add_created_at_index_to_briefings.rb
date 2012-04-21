class AddCreatedAtIndexToBriefings < ActiveRecord::Migration
  def self.up
    add_index :briefings, :created_at
  end

  def self.down
    remove_index :briefings, :created_at
  end
end
