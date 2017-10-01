class AutopartPhoto < ActiveRecord::Base
  
  belongs_to :autopart
  
  has_attached_file :image
  
  validates :autopart_id, :image, presence: true 
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
