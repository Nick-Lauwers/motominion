class CreateFavoriteVehicles < ActiveRecord::Migration
  def change
    create_table :favorite_vehicles do |t|
      t.integer :user_id
      t.integer :vehicle_id

      t.timestamps null: false
    end
    
    add_index :favorite_vehicles, :user_id
    add_index :favorite_vehicles, :vehicle_id
    add_index :favorite_vehicles, [:user_id, :vehicle_id], unique: true
  end
end