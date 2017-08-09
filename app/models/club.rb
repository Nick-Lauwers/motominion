class Club < ActiveRecord::Base
  has_many :users,             through:   :memberships
  has_many :memberships,       dependent: :destroy
  
  has_attached_file :cover_photo
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
end