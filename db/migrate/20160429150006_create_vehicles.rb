class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.string      :vehicle_condition
      t.string      :body_style
      t.string      :color
      t.string      :transmission
      t.string      :fuel_type
      t.string      :drivetrain
      t.string      :vin
      t.string      :listing_name
      t.string      :address
      t.string      :monday_availability
      t.string      :tuesday_availability
      t.string      :wednesday_availability
      t.string      :thursday_availability
      t.string      :friday_availability
      t.string      :saturday_availability
      t.string      :sunday_availability
      t.integer     :year
      t.integer     :price
      t.integer     :mileage
      t.integer     :seating_capacity
      t.text        :summary
      t.text        :sellers_notes
      t.boolean     :is_leather_seats
      t.boolean     :is_sunroof 
      t.boolean     :is_navigation_system 
      t.boolean     :is_dvd_entertainment_system 
      t.boolean     :is_bluetooth
      t.boolean     :is_backup_camera
      t.boolean     :is_remote_start
      t.boolean     :is_tow_package
      t.boolean     :is_autonomy
      t.references  :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :vehicles, [:user_id, :created_at]
  end
end