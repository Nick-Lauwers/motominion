class AddReadAtToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :read_at, :datetime
  end
end
