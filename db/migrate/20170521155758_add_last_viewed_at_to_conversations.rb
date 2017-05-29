class AddLastViewedAtToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_last_viewed_at, :datetime
    add_column :conversations, :recipient_last_viewed_at, :datetime
  end
end
