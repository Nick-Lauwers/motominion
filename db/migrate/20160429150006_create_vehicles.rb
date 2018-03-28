class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.string      :body_style (cruiser, dual-sport, mini / pocket, moped, sportbike, standard, touring, trike, vintage)
      t.string      :color (keep)
      t.string      :transmission (engine-type: single, parallel-twin, inline-three, inline-four, v-twin, V4, flat-twin [boxer], L-twin, other, unknown)
      t.string      :fuel_type (keep)
      t.string      :vin (keep)
      t.string      :listing_name (keep)
      t.string      :street_address (keep)
      t.string      :apartment (keep)
      t.string      :city (keep)
      t.string      :state (keep)
      t.integer     :year (keep)
      t.integer     :price (keep)
      t.integer     :mileage (keep)
      t.integer     :engine_size (keep)
      t.text        :summary (keep)
      t.text        :sellers_notes (keep)
      t.boolean     :is_windscreen
      
      t.boolean     :is_leather_seats (is_windscreen)
      t.boolean     :is_sunroof (is_heated_seats, is_heated_hand_grips)
      t.boolean     :is_navigation_system (is_sidecar)
      t.boolean     :is_dvd_entertainment_system (is_tow_hitch)
      t.boolean     :is_bluetooth (is_trunk, is_saddlebags)
      t.boolean     :is_backup_camera (is_navigation_system)
      t.boolean     :is_remote_start (is_alarm_system, is_cb_radio, is_cruise_control, is_trailer, is_cycle_cover)
      t.boolean     :is_tow_package
      t.references  :user,          index: true, foreign_key: true
      t.references  :vehicle_make,  index: true, foreign_key: true
      t.references  :vehicle_model, index: true, foreign_key: true
      # t.references  :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :vehicles, [:user_id, :created_at]
  end
end