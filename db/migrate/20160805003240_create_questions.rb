class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :likes
      t.references :user,    index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :questions, [:vehicle_id, :created_at]
  end
end
