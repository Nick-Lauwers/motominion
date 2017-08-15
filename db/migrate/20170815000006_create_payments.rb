class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.boolean    :received
      t.references :user,    index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :payments, [:vehicle_id, :created_at]
  end
end
