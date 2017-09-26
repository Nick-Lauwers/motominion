class AddCachedVotesToDiscussions < ActiveRecord::Migration
  
  def self.up
    add_column :discussions, :cached_votes_up, :integer, :default => 0
    add_index  :discussions, :cached_votes_up
  end

  def self.down
    remove_column :discussions, :cached_votes_up
  end
end