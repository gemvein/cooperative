class CreatePermissionsTable < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.references  :user
      t.string      :permissible_type
      t.integer     :permissible_id
      t.string      :whom
      t.timestamps
    end
  end
  def self.down
    drop_table :permissions
  end
end