# delete unnecessary index: true

class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text       :comment
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :responses, [:post_id, :created_at]
  end
end