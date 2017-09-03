class DropClubPostsTable < ActiveRecord::Migration
  def up
    drop_table :club_posts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
