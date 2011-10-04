class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :not_null => true, :default => 'guest'
  end

  def self.down
    remove_column :users, :role
  end
end
