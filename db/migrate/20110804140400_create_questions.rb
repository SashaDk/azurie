class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :title
      t.text :answer
      t.text :category
      t.integer :question_author_id
      t.integer :answer_author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
