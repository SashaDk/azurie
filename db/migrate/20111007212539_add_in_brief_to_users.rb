class AddInBriefToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :in_brief, :text
  end

  def self.down
    remove_column :users, :in_brief
  end
end
