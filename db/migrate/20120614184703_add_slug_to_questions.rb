class AddSlugToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :slug, :string
    add_index :questions, :slug, unique: true
  end

  def self.down
    remove_column :questions, :slug
  end
end
