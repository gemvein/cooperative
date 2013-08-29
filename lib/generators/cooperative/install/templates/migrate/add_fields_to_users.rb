class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :bio, :text
    add_column :users, :public, :boolean, :default => true
    add_index :users, :nickname, :unique => true
    change_table :users do |t|
      t.has_attached_file :image
    end
  end
end
