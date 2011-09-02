class CreateBriefings < ActiveRecord::Migration
  def self.up
    create_table :briefings do |t|
      t.text :title
      t.text :description
      t.text :category
      t.text :source
      t.boolean :is_quote
      t.integer :user_id
      t.timestamp :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :briefings
  end
end
