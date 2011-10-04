class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :occupation, :string
    add_column :users, :company, :string
    add_column :users, :location, :string
    add_column :users, :contact_email, :string
    add_column :users, :google_plus, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :twitter, :string
  end

  def self.down
    remove_column :users, :twitter
    remove_column :users, :linkedin
    remove_column :users, :facebook
    remove_column :users, :google_plus
    remove_column :users, :contact_email
    remove_column :users, :location
    remove_column :users, :company
    remove_column :users, :occupation
  end
end
