class AddRotationToPhotos < ActiveRecord::Migration
  
  def self.up
    add_column :photos, :rotation, :integer, :null => false, :default => 0
  end
 
  def self.down
    remove_column :photos, :rotation
  end
end