class CreateVehicleSeries < ActiveRecord::Migration
  def change
    create_table :vehicle_series do |t|
      t.string :name
      t.references :vehicle_model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
