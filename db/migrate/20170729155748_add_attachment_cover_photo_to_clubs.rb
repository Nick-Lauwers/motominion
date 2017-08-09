class AddAttachmentCoverPhotoToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :clubs, :cover_photo
  end
end
