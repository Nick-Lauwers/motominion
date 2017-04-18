class AddCachedVotesToPosts < ActiveRecord::Migration
  def self.up
    
    add_column :posts, :cached_votes_up, :integer, :default => 0
    
    add_index  :posts, :cached_votes_up
  end

  def self.down
    remove_column :posts, :cached_votes_up
  end
end