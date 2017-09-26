class CreateVehicleMakes < ActiveRecord::Migration
  def change
    create_table :vehicle_makes do |t|
      t.string :name
      t.string :cover_photo_url

      t.timestamps null: false
    end
  end
end
