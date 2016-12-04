# complete

class Post < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :responses, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :content, presence: true
  validates :title, presence: true, length: { maximum: 70 }
end