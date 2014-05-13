class CreateDirectMessages < ActiveRecord::Migration
  def change
    create_table :direct_messages do |t|
      t.string :content
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
    add_index :direct_messages, :sender_id
    add_index :direct_messages, :recipient_id
  end
  def self.down
    drop_table :direct_messages
  end
end
