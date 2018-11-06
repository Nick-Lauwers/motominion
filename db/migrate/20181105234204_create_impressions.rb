class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.string :impression_type
      t.string :ip_address
      t.integer :count
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.references :dealership, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
