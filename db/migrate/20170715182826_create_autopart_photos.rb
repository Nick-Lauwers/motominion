class CreateAutopartPhotos < ActiveRecord::Migration
  def change
    create_table :autopart_photos do |t|
      t.references :autopart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
