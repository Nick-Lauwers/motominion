class AddAttachmentImageToMessagePhotos < ActiveRecord::Migration
  def self.up
    change_table :message_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :message_photos, :image
  end
end
