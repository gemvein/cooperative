class CreateGroupsTable < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.boolean :public, :default => true
      t.has_attached_file :image

      t.timestamps
    end
  end
end
