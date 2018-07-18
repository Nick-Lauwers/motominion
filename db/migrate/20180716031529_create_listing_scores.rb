class CreateListingScores < ActiveRecord::Migration
  def change
    create_table :listing_scores do |t|
      t.integer :location_score
      t.integer :features_score
      t.integer :spec_score
      t.integer :vin_score
      t.integer :certified_dealer_score
      t.integer :direct_listing_score
      t.integer :test_drive_score
      t.integer :photos_score
      t.integer :reviews_score
      t.integer :recently_posted_score
      t.integer :many_listings_score
      t.integer :overall_score
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end