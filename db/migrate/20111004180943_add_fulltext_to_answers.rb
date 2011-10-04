class AddFulltextToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :fulltext, :text
  end

  def self.down
    remove_column :answers, :fulltext
  end
end
