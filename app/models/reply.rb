# complete

class Reply < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :comment
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :comment_id, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end