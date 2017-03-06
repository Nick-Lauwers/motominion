class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string     :status
      t.datetime   :date
      t.integer    :seller_id
      t.references :buyer
      t.references :vehicle,      index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_foreign_key :appointments, :users, column: :buyer_id
    add_index :appointments, [:buyer_id, :date]
  end
end