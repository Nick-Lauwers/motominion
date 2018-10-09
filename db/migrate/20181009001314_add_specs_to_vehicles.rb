class AddSpecsToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :displacement, :string
    add_column :vehicles, :dry_weight, :string
    add_column :vehicles, :engine, :string
    add_column :vehicles, :fuel_capacity, :string
    add_column :vehicles, :transmission, :string
    add_column :vehicles, :trim_details, :string
    add_column :vehicles, :primary_drive, :string
    add_column :vehicles, :final_drive, :string
    add_column :vehicles, :bore_stroke, :string
    add_column :vehicles, :bore, :string
    add_column :vehicles, :stroke, :string
    add_column :vehicles, :compression_ratio, :string
    add_column :vehicles, :fuel_system, :string
    add_column :vehicles, :suspension, :string
    add_column :vehicles, :front_suspension, :string
    add_column :vehicles, :rear_suspension, :string
    add_column :vehicles, :brakes, :string
    add_column :vehicles, :front_brakes, :string
    add_column :vehicles, :rear_brakes, :string
    add_column :vehicles, :tires, :string
    add_column :vehicles, :front_tire, :string
    add_column :vehicles, :rear_tire, :string
    add_column :vehicles, :curb_weight, :string
    add_column :vehicles, :wheelbase, :string
    add_column :vehicles, :ground_clearance, :string
    add_column :vehicles, :seat_height, :string
    add_column :vehicles, :seat_height_laden, :string
    add_column :vehicles, :seat_height_unladen, :string
    add_column :vehicles, :rake_trail, :string
    add_column :vehicles, :rake, :string
    add_column :vehicles, :trail, :string
  end
end
