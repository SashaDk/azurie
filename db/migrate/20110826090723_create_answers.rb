class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :text
      t.integer :user_id
      t.integer :answer_id
      t.timestamp :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
