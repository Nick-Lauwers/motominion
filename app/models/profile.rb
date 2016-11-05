class Profile < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  
  validates :residence, :school, :work, length: { maximum: 50 }
  
  has_attached_file :avatar, 
    default_url: "/assets/profile.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
