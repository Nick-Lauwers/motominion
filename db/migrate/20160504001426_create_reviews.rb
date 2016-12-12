class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      
      t.string :title
      t.text :comment
      t.integer :rating
      t.references :vehicle, index: true, foreign_key: true
      t.references :user,    index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
