class CreateVehicleSpecificationValues < ActiveRecord::Migration
  def change
    create_table :vehicle_specification_values do |t|
      t.string :value
      t.string :unit
      t.references :vehicle_trim, index: true, foreign_key: true
      t.references :vehicle_specification, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
