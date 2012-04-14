class AddIsTopToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :is_top, :boolean
    add_index :questions, :is_top
  end

  def self.down
    remove_column :questions, :is_top
  end
end
