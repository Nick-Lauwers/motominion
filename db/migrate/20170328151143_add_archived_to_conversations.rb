class AddArchivedToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_archived,    :boolean
    add_column :conversations, :recipient_archived, :boolean
  end
end
