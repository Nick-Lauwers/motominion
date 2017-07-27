class CreateFavoriteAutoparts < ActiveRecord::Migration
  def change
    create_table :favorite_autoparts do |t|
      t.references :user,     foreign_key: true
      t.references :autopart, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :favorite_autoparts, [:user_id, :created_at]
    add_index :favorite_autoparts, [:user_id, :autopart_id], unique: true
  end
end