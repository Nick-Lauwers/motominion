class CreateMessagePhotos < ActiveRecord::Migration
  def change
    create_table :message_photos do |t|

      t.timestamps null: false
    end
  end
end
