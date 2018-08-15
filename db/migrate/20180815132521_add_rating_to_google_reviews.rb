class AddRatingToGoogleReviews < ActiveRecord::Migration
  def change
    add_column :google_reviews, :rating, :float
  end
end
