class AddAttachmentImageToAutopartPhotos < ActiveRecord::Migration
  def self.up
    change_table :autopart_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :autopart_photos, :image
  end
end
