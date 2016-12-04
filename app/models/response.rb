# complete

class Response < ActiveRecord::Base
  
  belongs_to :post
  belongs_to :user
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :post_id, :comment, presence: true
end
