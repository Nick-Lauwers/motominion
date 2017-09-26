# delete unnecessary index: true

class CreateDiscussionComments < ActiveRecord::Migration
  def change
    
    create_table :discussion_comments do |t|
      
      t.text       :comment
      t.references :discussion, index: true, foreign_key: true
      t.references :user,       index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :discussion_comments, [:discussion_id, :created_at]
  end
end