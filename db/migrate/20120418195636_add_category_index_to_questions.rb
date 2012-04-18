class AddCategoryIndexToQuestions < ActiveRecord::Migration
  def self.up
    add_index :questions, :category
  end

  def self.down
    remove_index :questions, :category
  end
end
