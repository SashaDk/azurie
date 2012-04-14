class AddIndexesToQuestions < ActiveRecord::Migration
  def self.up
    add_index :questions, :state
    add_index :questions, :created_at
    add_index :questions, [:answers_count, :state]
    add_index :questions, :title
    add_index :questions, :user_id
  end

  def self.down
    remove_index :questions, :state
    remove_index :questions, :created_at
    remove_index :questions, [:answers_count, :state]
    remove_index :questions, :title
    remove_index :questions, :user_id
  end
end
