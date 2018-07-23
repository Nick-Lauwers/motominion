class AddGooglePlaceIdToDealerships < ActiveRecord::Migration
  def change
    add_column :dealerships, :google_place_id, :string
  end
end
