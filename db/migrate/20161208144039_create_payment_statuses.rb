class CreatePaymentStatuses < ActiveRecord::Migration
  def change
    create_table :payment_statuses do |t|
      t.string     :action
      t.string     :message
      t.string     :authorization
      t.text       :params
      t.integer    :amount
      t.boolean    :success
      t.references :payment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
