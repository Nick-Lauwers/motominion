class AddFieldsToVehicleModels < ActiveRecord::Migration
  def change
    add_column :vehicle_models, :type, :string
    add_column :vehicle_models, :is_one_seat, :boolean
    add_column :vehicle_models, :is_two_seats, :boolean
    add_column :vehicle_models, :is_beginner, :boolean
    add_column :vehicle_models, :is_intermediate, :boolean
    add_column :vehicle_models, :is_advanced, :boolean
  end
end
