# complete

class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :vehicle
  
  has_many :replies, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, :vehicle_id, presence: true
  validates :title,      presence: true, length: { maximum: 20 }
  validates :content,    presence: true, length: { maximum: 150 }
end
