class AddVideoToBriefings < ActiveRecord::Migration
  def self.up
    add_column :briefings, :video, :text
  end

  def self.down
    remove_column :briefings, :video
  end
end
