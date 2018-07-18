class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.references :user,          index: true, foreign_key: true
      t.string     :listing_name
      t.string     :vehicle_make_name
      t.references :vehicle_make,  index: true, foreign_key: true
      t.string     :vehicle_model_name
      t.references :vehicle_model, index: true, foreign_key: true
      t.integer    :msrp
      t.integer    :actual_price
      t.integer    :year
      t.string     :mileage
      t.integer    :mileage_numeric
      t.string     :body_style
      t.string     :color
      t.string     :engine_type
      t.string     :fuel_type
      t.string     :vin
      t.integer    :engine_size
      t.text       :description
      t.text       :description_clean
      t.boolean    :cruise_control
      t.boolean    :am_fm
      t.boolean    :cb_radio
      t.boolean    :navigation_system
      t.boolean    :heated_seats
      t.boolean    :heated_hand_grips
      t.boolean    :alarm_system
      t.boolean    :saddlebags
      t.boolean    :trunk
      t.boolean    :tow_hitch
      t.boolean    :cycle_cover
      t.string     :street_address
      t.string     :apartment
      t.string     :city
      t.string     :state
      t.string     :ad_url
      t.datetime   :last_found_at

      t.timestamps null: false
    end
    
    add_index :vehicles, [:user_id, :created_at]
  end
end