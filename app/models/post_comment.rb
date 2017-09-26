class PostComment < ActiveRecord::Base
  
  belongs_to :post
  belongs_to :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :post_id, presence: true
  validates :content,           presence: true, length: { maximum: 500 }
end
