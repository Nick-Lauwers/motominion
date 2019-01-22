class RemoveUserFromVehicleViews < ActiveRecord::Migration
  def change
    remove_foreign_key :vehicle_views, :users
  end
end
