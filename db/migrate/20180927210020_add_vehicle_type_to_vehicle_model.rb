class AddVehicleTypeToVehicleModel < ActiveRecord::Migration
  def change
    add_column :vehicle_models, :vehicle_type, :string
  end
end
