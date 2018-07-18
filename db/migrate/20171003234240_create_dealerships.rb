class CreateDealerships < ActiveRecord::Migration
  def change
    create_table :dealerships do |t|
      t.string     :dealership_name
      t.string     :scrape_name
      t.string     :email
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
