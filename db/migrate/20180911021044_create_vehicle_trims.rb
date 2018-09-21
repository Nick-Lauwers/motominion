class CreateVehicleTrims < ActiveRecord::Migration
  def change
    create_table :vehicle_trims do |t|
      t.string :name
      t.integer :first_production_year
      t.integer :last_production_year
      t.references :vehicle_series, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
