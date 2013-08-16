class CreateStatusesTable < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :user
      t.text :body

      t.timestamps
    end
    add_index :statuses, :user_id
  end
end
