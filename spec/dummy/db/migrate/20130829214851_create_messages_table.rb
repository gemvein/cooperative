class CreateMessagesTable < ActiveRecord::Migration
   def self.up
     create_table :messages do |t|
       t.integer :sender_id
       t.integer :recipient_id
       t.integer :parent_id
       t.string :subject
       t.text :body
       t.boolean :deleted_by_sender
       t.boolean :deleted_by_recipient
       t.timestamp :read_at
       t.timestamps
    end
    add_index :messages, [:sender_id, :deleted_by_sender]
    add_index :messages, [:recipient_id, :deleted_by_recipient]
    add_index :messages, :parent_id
  end

  def self.down
    drop_table :messages
  end
end