class ChangeUserIdOnQuestions < ActiveRecord::Migration
  def self.up
    change_column :questions, :user_id, :integer, :not_null => true
  end

  def self.down
    change_column :questions, :user_id, :integer
  end
end
