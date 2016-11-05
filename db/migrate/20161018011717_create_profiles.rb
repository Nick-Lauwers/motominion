class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :residence
      t.string :school
      t.string :work
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
