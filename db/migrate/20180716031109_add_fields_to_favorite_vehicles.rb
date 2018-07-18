class AddFieldsToFavoriteVehicles < ActiveRecord::Migration
  def change
    add_column :favorite_vehicles, :is_liked,      :boolean
    add_column :favorite_vehicles, :is_loved,      :boolean
    add_column :favorite_vehicles, :is_test_drive, :boolean
    add_column :favorite_vehicles, :is_purchase,   :boolean
  end
end