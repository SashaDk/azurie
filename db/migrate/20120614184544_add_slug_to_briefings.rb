class AddSlugToBriefings < ActiveRecord::Migration
  def self.up
    add_column :briefings, :slug, :string
    add_index :briefings, :slug, unique: true
  end

  def self.down
    remove_column :briefings, :slug
  end
end
