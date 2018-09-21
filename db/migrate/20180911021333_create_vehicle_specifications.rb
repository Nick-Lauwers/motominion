class CreateVehicleSpecifications < ActiveRecord::Migration
  def change
    create_table :vehicle_specifications do |t|
      t.string :name
      t.integer :class_id

      t.timestamps null: false
    end
  end
end
