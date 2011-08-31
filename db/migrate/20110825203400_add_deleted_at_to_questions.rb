class AddDeletedAtToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :deleted_at, :timestamp
  end

  def self.down
    remove_column :questions, :deleted_at
  end
end
