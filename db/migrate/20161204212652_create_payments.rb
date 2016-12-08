class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expiration
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end