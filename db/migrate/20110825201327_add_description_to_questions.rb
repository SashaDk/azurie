class AddDescriptionToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :description, :text
  end

  def self.down
    remove_column :questions, :description
  end
end
