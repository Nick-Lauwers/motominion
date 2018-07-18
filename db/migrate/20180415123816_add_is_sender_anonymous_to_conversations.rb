class AddIsSenderAnonymousToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :is_sender_anonymous, :boolean, default: true
  end
end