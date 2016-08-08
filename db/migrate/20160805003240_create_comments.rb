class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.text :title
      t.text :content

      t.timestamps null: false
    end
    add_index :comments, [:vehicle_id, :created_at]
  end
end
