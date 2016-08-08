class Photo < ActiveRecord::Base
  belongs_to :vehicle
  
  has_attached_file :image, 
    styles: { medium: "300x300>", small: "250x250>", thumb: "100x100>" }
  
  validates                         :vehicle_id, presence: true
  validates                         :image,      presence: true 
  validates_attachment_content_type :image,      content_type: /\Aimage\/.*\Z/
end