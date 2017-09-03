class CreateClubResponses < ActiveRecord::Migration
  def change
    create_table :club_responses do |t|
      
      t.text :comment
      t.references :user,      index: true, foreign_key: true
      t.references :club_post, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :club_responses, [:club_post_id, :created_at]
  end
end
