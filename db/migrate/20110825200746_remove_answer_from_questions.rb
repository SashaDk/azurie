class RemoveAnswerFromQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :answer
  end

  def self.down
    add_column :questions, :answer, :text
  end
end
