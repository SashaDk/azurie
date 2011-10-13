class AddColumnToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :answers_count, :integer
    Question.reset_column_information
    Question.find(:all).each do |q|
      Question.update_counters q.id, :answers_count => q.answers.count
    end
  end

  def self.down
    remove_column :users, :answers_count
  end
end
