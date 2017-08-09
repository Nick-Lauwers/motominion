class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.boolean :admin
      t.references :user, foreign_key: true
      t.references :club, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :memberships, [:user_id, :created_at]
    add_index :memberships, [:user_id, :club_id], unique: true
  end
end
