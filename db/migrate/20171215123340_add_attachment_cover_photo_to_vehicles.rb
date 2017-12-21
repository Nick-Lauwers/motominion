class AddAttachmentCoverPhotoToVehicles < ActiveRecord::Migration
  def self.up
    change_table :vehicles do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :vehicles, :cover_photo
  end
end
