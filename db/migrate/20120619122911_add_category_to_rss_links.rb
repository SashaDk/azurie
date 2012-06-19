class AddCategoryToRssLinks < ActiveRecord::Migration
  def self.up
    add_column :rss_links, :category, :string, :null => false, :default => 'popular'
  end

  def self.down
    remove_column :rss_links, :category
  end
end
