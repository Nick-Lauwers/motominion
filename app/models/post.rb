class Post < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :post_comments, dependent: :destroy
  
  acts_as_votable
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  
  has_attached_file :photo,
    styles:      { small: "500x500#" },
    default_url: "https://s3.us-east-2.amazonaws.com/motominion-assets/static-assets/photo.png"
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end