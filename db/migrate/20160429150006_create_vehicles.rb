class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.string      :body_style
      t.string      :color
      t.string      :engine_type
      t.string      :fuel_type
      t.string      :vin
      t.string      :listing_name
      t.string      :street_address
      t.string      :apartment
      t.string      :city
      t.string      :state
      t.integer     :year
      t.integer     :price
      t.integer     :mileage
      t.integer     :engine_size
      t.text        :summary
      t.text        :sellers_notes
      t.boolean     :is_cruise_control
      t.boolean     :is_am_fm
      t.boolean     :is_cb_radio
      t.boolean     :is_navigation_system
      t.boolean     :is_heated_seats
      t.boolean     :is_heated_hand_grips
      t.boolean     :is_alarm_system
      t.boolean     :is_saddlebags
      t.boolean     :is_trunk
      t.boolean     :is_tow_hitch
      t.boolean     :is_cycle_cover
      t.references  :user,          index: true, foreign_key: true
      t.references  :vehicle_make,  index: true, foreign_key: true
      t.references  :vehicle_model, index: true, foreign_key: true
      # t.references  :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :vehicles, [:user_id, :created_at]
  end
end