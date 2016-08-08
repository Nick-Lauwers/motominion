class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.datetime :date

      t.timestamps null: false
    end
    add_index :appointments, [:user_id, :date]
  end
end