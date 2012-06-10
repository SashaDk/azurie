class AddCacheToRssLinks < ActiveRecord::Migration
  def self.up
    add_column :rss_links, :items_data, :text
    add_column :rss_links, :shares_data, :text
  end

  def self.down
    remove_column :rss_links, :shares_data
    remove_column :rss_links, :items_data
  end
end
