class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.string :day
      t.time :open_time
      t.time :close_time
      t.boolean :is_closed
      t.references :dealership, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
