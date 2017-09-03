class Club < ActiveRecord::Base
  
  searchkick word_start: [:city]
  
  has_many :memberships,       dependent: :destroy
  has_many :invitations,       dependent: :destroy
  has_many :users,             through:   :memberships
  
  validates :name, :description, :city, :state, presence: true
  
  has_attached_file :cover_photo
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
end