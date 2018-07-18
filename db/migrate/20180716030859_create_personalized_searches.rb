class CreatePersonalizedSearches < ActiveRecord::Migration
  def change
    create_table :personalized_searches do |t|
      
      t.integer :price
      t.integer :mileage
      t.integer :year
      t.boolean :is_classic_vintage
      t.boolean :is_cruiser
      t.boolean :is_dual_sport
      t.boolean :is_mini_pocket
      t.boolean :is_moped
      t.boolean :is_sportbike
      t.boolean :is_standard
      t.boolean :is_touring
      t.boolean :is_trike
      t.boolean :cruise_control
      t.boolean :am_fm
      t.boolean :cb_radio
      t.boolean :navigation_system
      t.boolean :heated_seats
      t.boolean :heated_hand_grips
      t.boolean :alarm_system
      t.boolean :saddlebags
      t.boolean :trunk
      t.boolean :tow_hitch
      t.boolean :cycle_cover
      
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end