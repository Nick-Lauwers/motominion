class RemoveVehicleFromImpressions < ActiveRecord::Migration
  def change
    remove_foreign_key :impressions, :vehicles
  end
end
