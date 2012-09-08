class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :page
      t.references :user
      t.string :slug
      t.string :title
      t.text :description
      t.text :keywords
      t.text :body
      t.boolean :public

      t.timestamps
    end
    add_index :pages, :page_id
    add_index :pages, :user_id
  end
end
