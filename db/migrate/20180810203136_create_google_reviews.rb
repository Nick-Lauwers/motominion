class CreateGoogleReviews < ActiveRecord::Migration
  def change
    create_table :google_reviews do |t|
      t.string :author_name
      t.string :profile_photo_url
      t.text :text
      t.integer :time
      t.references :dealership, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
