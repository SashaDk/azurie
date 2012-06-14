class ChangeDataLimitOfRssLinks < ActiveRecord::Migration
  def self.up
    change_column :rss_links, :items_data, :text, :limit => 10485760
    change_column :rss_links, :shares_data, :text, :limit => 10485760
  end

  def self.down
    change_column :rss_links, :items_data, :text
    change_column :rss_links, :shares_data, :text
  end
end
