class AddAttachmentLogoToDealerships < ActiveRecord::Migration
  def self.up
    change_table :dealerships do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :dealerships, :logo
  end
end
