class CreatePaymentStatuses < ActiveRecord::Migration
  def change
    create_table :payment_statuses do |t|
      
      t.string :action
      t.string :authorization
      t.string :message
      t.integer :amount
      t.text :params
      t.boolean :success
      t.references :payment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
