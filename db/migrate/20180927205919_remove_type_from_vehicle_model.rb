class RemoveTypeFromVehicleModel < ActiveRecord::Migration
  def change
    remove_column :vehicle_models, :type, :string
  end
end
