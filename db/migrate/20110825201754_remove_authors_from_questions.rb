class RemoveAuthorsFromQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :question_author_id
    remove_column :questions, :answer_author_id
  end

  def self.down
    add_column :questions, :answer_author_id, :integer
    add_column :questions, :question_author_id, :integer
  end
end
