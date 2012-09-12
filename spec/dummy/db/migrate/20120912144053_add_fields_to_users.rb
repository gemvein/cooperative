class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :bio, :text
    add_column :users, :public, :boolean, :default => true
    add_index :users, :nickname, :unique => true
  end
end
