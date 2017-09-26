class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      
      t.string     :title
      t.text       :content
      t.references :user,          index: true, foreign_key: true
      t.references :club,          index: true, foreign_key: true
      t.references :vehicle_make,  index: true, foreign_key: true
      t.references :vehicle_model, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :discussions, [:user_id, :created_at]
    add_index :discussions, [:club_id, :created_at]
    add_index :discussions, [:vehicle_make_id, :created_at]
    add_index :discussions, [:vehicle_model_id, :created_at]
  end
end