class CreateSharesTable < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :user
      t.integer :shareable_id
      t.string :shareable_type
      t.string :url
      t.text :body
      t.string :title

      t.timestamps
    end
    add_index :shares, :user_id
    add_index :shares, [:shareable_id, :shareable_type]
  end
end
