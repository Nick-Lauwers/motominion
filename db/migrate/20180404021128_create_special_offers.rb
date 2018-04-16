class CreateSpecialOffers < ActiveRecord::Migration
  def change
    create_table :special_offers do |t|
      t.string :title
      t.text :description
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
