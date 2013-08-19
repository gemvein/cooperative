class AddFieldsToStatuses < ActiveRecord::Migration
  def up
    add_column :statuses, :url, :string
    add_column :statuses, :title, :string
    add_column :statuses, :description, :string
    change_table :statuses do |t|
      t.has_attached_file :image
    end
  end
  def down
    drop_attached_file :statuses, :image
    drop_column :statuses, :url
    drop_column :statuses, :title
    drop_column :statuses, :description
  end
end