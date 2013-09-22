class CreateStatusesTable < ActiveRecord::Migration
  def up
    create_table :statuses do |t|
      t.references :user
      t.string :shareable_type
      t.integer :shareable_id
      t.text :body
      t.string :url
      t.string :title
      t.text :description
      t.string :media_url
      t.string :media_type

      t.timestamps
    end
    change_table :statuses do |t|
      t.has_attached_file :image
    end
    add_index :statuses, :user_id
    add_index :statuses, [:shareable_type, :shareable_id]
  end

  def down
    drop_table :statuses
  end
end
