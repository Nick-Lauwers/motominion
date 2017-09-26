class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text       :content
      t.integer    :likes
      t.references :user,     index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :answers, [:question_id, :created_at]
  end
end
