class AddSocialCountersToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :likes_count, :integer, :default => 0, :null => false
    add_column :answers, :comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :answers, :comments_count
    remove_column :answers, :likes_count
  end
end
