class AddMediaToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :media_url, :string
    add_column :statuses, :media_type, :string
  end
end
