class CreateUpgrades < ActiveRecord::Migration
  def change
    create_table :upgrades do |t|
      t.string :title
      # t.string :description
      t.integer :duration
      t.integer :price
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
