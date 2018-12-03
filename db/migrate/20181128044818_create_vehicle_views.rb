class CreateVehicleViews < ActiveRecord::Migration
  def change
    create_table :vehicle_views do |t|
      t.string :ip_address
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
