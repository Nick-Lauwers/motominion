class AddAttachmentImageToClubProductPhotos < ActiveRecord::Migration
  def self.up
    change_table :club_product_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :club_product_photos, :image
  end
end
