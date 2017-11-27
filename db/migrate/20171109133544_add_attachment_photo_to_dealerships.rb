class AddAttachmentPhotoToDealerships < ActiveRecord::Migration
  def self.up
    change_table :dealerships do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :dealerships, :photo
  end
end
