class ChangeAnswerCountColumnOfQuestions < ActiveRecord::Migration
  def self.up
    Question.where(:answers_count => nil).update_all :answers_count => 0
    change_column :questions, :answers_count, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :questions, :answers_count, :integer
  end
end
