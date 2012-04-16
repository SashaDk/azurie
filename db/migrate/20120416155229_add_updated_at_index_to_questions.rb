class AddUpdatedAtIndexToQuestions < ActiveRecord::Migration
  def self.up
    add_index :questions, :updated_at
  end

  def self.down
    remove_index :questions, :updated_at
  end
end
