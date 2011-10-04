class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :user_id, :not_null => true
      t.integer :question_id, :not_null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
