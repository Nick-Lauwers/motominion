class Blog < ActiveRecord::Base
  
  belongs_to :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :title,   presence: true
    # , length: { maximum: 70 }
  validates :content, presence: true
    # , length: { maximum: 500 }
  
  has_attached_file :cover_photo
  validates_attachment_presence :cover_photo
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
end
