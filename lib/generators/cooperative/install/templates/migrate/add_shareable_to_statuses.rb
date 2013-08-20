class AddShareableToStatuses < ActiveRecord::Migration
  def up
    add_column :statuses, :shareable_type, :string
    add_column :statuses, :shareable_id, :integer
    add_index :statuses, [:shareable_type, :shareable_id]
  end
  def down
    drop_index :statuses, [:shareable_type, :shareable_id]
    drop_column :statuses, :shareable_type
    drop_column :statuses, :shareable_id
  end
end
