class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer    :next_contributor_id
      t.boolean    :latest_message_read
      t.references :sender
      t.references :recipient

      t.timestamps null: false
    end
    
    add_foreign_key :conversations, :users, column: :sender_id
    add_foreign_key :conversations, :users, column: :recipient_id
  end
end
