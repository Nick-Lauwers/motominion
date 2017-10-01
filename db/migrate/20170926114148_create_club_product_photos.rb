class CreateClubProductPhotos < ActiveRecord::Migration
  def change
    create_table :club_product_photos do |t|
      t.references :club_product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
