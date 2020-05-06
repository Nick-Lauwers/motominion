class Photo < ActiveRecord::Base
  
  belongs_to :vehicle

  has_attached_file :image      

  validates :vehicle_id, :image, presence: true 
  validates_attachment_content_type :image,      content_type: /\Aimage\/.*\Z/
  
  default_scope -> { order(id: :asc) }
end