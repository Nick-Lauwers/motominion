class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :category
      t.text :content

      t.timestamps null: false
    end
  end
end