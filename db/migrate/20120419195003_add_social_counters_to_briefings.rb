class AddSocialCountersToBriefings < ActiveRecord::Migration
  def self.up
    add_column :briefings, :likes_count, :integer, :default => 0, :null => false
    add_column :briefings, :comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :briefings, :comments_count
    remove_column :briefings, :likes_count
  end
end
