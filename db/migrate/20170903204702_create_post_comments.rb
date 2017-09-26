class CreatePostComments < ActiveRecord::Migration
  def change
    
    create_table :post_comments do |t|
      
      t.string     :content
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :post_comments, [:post_id, :created_at]
  end
end
