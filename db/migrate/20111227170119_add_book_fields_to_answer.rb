class AddBookFieldsToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :book_name, :text
    add_column :answers, :book_author, :string
    add_column :answers, :book_link, :string
  end

  def self.down
    remove_column :answers, :book_link
    remove_column :answers, :book_author
    remove_column :answers, :book_name
  end
end
