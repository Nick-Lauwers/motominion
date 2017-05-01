class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
