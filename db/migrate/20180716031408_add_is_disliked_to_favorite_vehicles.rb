class AddIsDislikedToFavoriteVehicles < ActiveRecord::Migration
  def change
    add_column :favorite_vehicles, :is_disliked, :boolean
  end
end