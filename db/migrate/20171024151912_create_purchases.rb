class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      
      t.string     :first_name
      t.string     :last_name
      t.string     :email
      t.string     :phone_number
      t.string     :billing_first_name
      t.string     :billing_last_name
      t.string     :billing_street_address
      t.string     :billing_apartment
      t.string     :billing_city
      t.string     :billing_state
      t.string     :education
      t.string     :employment
      t.string     :employer_name
      t.string     :employer_phone
      t.string     :current_title
      t.string     :residence_type
      t.integer    :annual_income
      t.integer    :time_at_job
      t.integer    :monthly_payment
      t.integer    :time_at_address
      t.boolean    :is_extended_service_contract
      t.boolean    :is_wheel_tire_care
      t.boolean    :is_ding_dent_care
      t.boolean    :is_key_replacement
      t.boolean    :is_resistall_protection
      t.datetime   :date_of_birth
      t.datetime   :processed_at
      t.references :buyer
      t.references :seller
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :purchases, [:buyer_id,  :created_at]
    add_index :purchases, [:seller_id, :created_at]
    
    add_foreign_key :purchases, :users, column: :buyer_id
    add_foreign_key :purchases, :users, column: :seller_id
  end
end
