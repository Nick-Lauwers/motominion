class CreateVehicleInquiries < ActiveRecord::Migration
  def change
    create_table :vehicle_inquiries do |t|
      t.boolean :price,           default: false
      t.boolean :special_offers,  default: false
      t.boolean :availability,    default: false
      t.boolean :condition,       default: false
      t.boolean :vehicle_history, default: false
      t.boolean :test_drives,     default: false
      t.references :user,         index: true, foreign_key: true
      t.references :vehicle,      index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
