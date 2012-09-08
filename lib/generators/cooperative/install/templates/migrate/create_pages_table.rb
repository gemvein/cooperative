class CreatePagesTable < ActiveRecord::Migration
   def self.up
     create_table :pages do |t|
       t.integer :parent_id
       t.integer :user_id
       t.string :slug
       t.string :title
       t.text :description
       t.text :keywords
       t.text :body
       t.boolean :public
       t.timestamps
    end
    add_index :pages, :slug
    add_index :pages, :parent_id
    add_index :pages, :user_id
  end

  def self.down
    drop_table :pages
  end
end