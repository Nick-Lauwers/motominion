class CreateClubProducts < ActiveRecord::Migration
  def change
    create_table :club_products do |t|
      t.string  :name
      t.integer :price
      t.text    :description
      t.text    :shipping_info
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
