class ClubProductPhoto < ActiveRecord::Base
  
  belongs_to :club_product
  
  has_attached_file :image
  
  validates :club_product_id, :image, presence: true 
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
