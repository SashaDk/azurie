class CreateRssLinks < ActiveRecord::Migration
  def self.up
    create_table :rss_links do |t|
      t.text :link
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :rss_links
  end
end
