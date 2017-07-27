class AutopartPhoto < ActiveRecord::Base
  belongs_to :autopart
  
  has_attached_file :image, 
    styles: { medium: "300x300>", small: "250x250>", thumb: "100x100>" }
  
  validates :autopart_id, :image, presence: true 
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
