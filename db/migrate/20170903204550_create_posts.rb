class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string     :content
      t.references :user,          index: true, foreign_key: true
      t.references :club,          index: true, foreign_key: true
      t.references :vehicle_make,  index: true, foreign_key: true
      t.references :vehicle_model, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :posts, [:user_id, :created_at]
    add_index :posts, [:club_id, :created_at]
    add_index :posts, [:vehicle_make_id, :created_at]
    add_index :posts, [:vehicle_model_id, :created_at]
  end
end