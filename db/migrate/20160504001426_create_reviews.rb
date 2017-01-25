class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      
      t.string :title
      t.text :comment
      t.integer :rating
      t.references :reviewer
      t.references :reviewed
      t.references :vehicle,  foreign_key: true
      
      t.timestamps null: false
    end
    
    add_index :reviews, [:vehicle_id,  :created_at]
    add_index :reviews, [:reviewer_id, :created_at]
    add_index :reviews, [:reviewed_id, :created_at]
    
    add_foreign_key :reviews, :users, column: :reviewer_id
    add_foreign_key :reviews, :users, column: :reviewed_id
  end
end
