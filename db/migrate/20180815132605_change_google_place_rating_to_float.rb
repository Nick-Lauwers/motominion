class ChangeGooglePlaceRatingToFloat < ActiveRecord::Migration
  def up
    change_column :dealerships, :google_place_rating, :float
  end

  def down
    change_column :dealerships, :google_place_rating, :integer
  end
end
