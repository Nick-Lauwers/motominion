class CreateVehicleModels < ActiveRecord::Migration
  def change
    create_table :vehicle_models do |t|
      t.string :name
      t.references :vehicle_make, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
