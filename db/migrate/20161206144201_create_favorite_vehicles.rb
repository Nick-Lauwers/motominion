class CreateFavoriteVehicles < ActiveRecord::Migration
  def change
    create_table :favorite_vehicles do |t|
      t.references :user,    foreign_key: true
      t.references :vehicle, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :favorite_vehicles, [:user_id, :created_at]
    add_index :favorite_vehicles, [:user_id, :vehicle_id], unique: true
  end
end