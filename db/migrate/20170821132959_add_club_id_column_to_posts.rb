class AddClubIdColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :club_id, :integer
  end
end
