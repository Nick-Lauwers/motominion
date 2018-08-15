class AddGooglePlaceRatingToDealership < ActiveRecord::Migration
  def change
    add_column :dealerships, :google_place_rating, :integer
  end
end
