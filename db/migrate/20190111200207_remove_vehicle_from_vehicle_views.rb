class RemoveVehicleFromVehicleViews < ActiveRecord::Migration
  def change
    remove_foreign_key :vehicle_views, :vehicles
  end
end
